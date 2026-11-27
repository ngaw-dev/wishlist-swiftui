import Foundation

enum ApiError: LocalizedError {
    case invalidData
    case jsonParserError
    case decodingError(error: Error)
    case requestFailed(description: String)
    case invalidStatusCode(code: Int)
    case urlBuildingFailed
    case noInternetConnection
    case unauthorized
    case notFound
    case rateLimited
    case serverError(code: Int)
    case unknownError(error: Error)

    /// Every user-facing message ends with a stable reference number so
    /// support can correlate user reports with server logs.
    var errorCode: Int {
        switch self {
        case .invalidData: return 4815
        case .jsonParserError: return 1138
        case .decodingError: return 3141
        case .requestFailed: return 8675
        case let .invalidStatusCode(code): return code
        case .urlBuildingFailed: return 73
        case .noInternetConnection: return 0
        case .unauthorized: return 401
        case .notFound: return 404
        case .rateLimited: return 429
        case let .serverError(code): return code
        case .unknownError: return 9001
        }
    }

    var userMsg: String {
        if case let .invalidStatusCode(code) = self {
            return "\(Self.userMsg(forStatusCode: code)) Error code #\(code)"
        }
        return "\(baseUserMsg) Error code #\(errorCode)"
    }

    /// Views can render any Error via localizedDescription; route it back to
    /// our user-facing message when the error is (or wraps) an ApiError.
    var errorDescription: String? {
        userMsg
    }

    static func userMessage(for error: Error) -> String {
        if let apiError = error as? ApiError {
            return apiError.userMsg
        }
        return error.localizedDescription
    }

    /// Views often render the message one sentence per line (title + retry hint),
    /// so split the user-facing message into sentences, keeping punctuation.
    var userMsgSentences: [String] {
        var sentences: [String] = []
        var current = ""

        for char in userMsg {
            current.append(char)
            // "!" ends sentences like "Easy there, speed racer!" but also
            // appears inside "sideways." — only split when followed by a space.
            if char == "." || char == "!" || char == "?" {
                sentences.append(current.trimmingCharacters(in: .whitespaces))
                current = ""
            }
        }

        if !current.isEmpty {
            sentences.append(current.trimmingCharacters(in: .whitespaces))
        }
        return sentences
    }

    private var baseUserMsg: String {
        switch self {
        case .invalidData: return "Hmm, we got some unexpected data. Please try again."
        case .jsonParserError: return "Something got lost on the way from the server. Please try again."
        case .decodingError: return "We had trouble reading the server's response. Please try again."
        case .requestFailed: return "We couldn't reach the server. Please try again."
        case .invalidStatusCode: return "Oops, something went wrong. Please try again."
        case .urlBuildingFailed: return "We couldn't set up that request. Please try again."
        case .noInternetConnection: return "You appear to be offline. Check your connection and try again."
        case .unauthorized: return "Your session has expired. Please sign in again."
        case .notFound: return "We couldn't find what you were looking for. Maybe it moved?"
        case .rateLimited: return "Easy there, speed racer! Give it a moment and try again."
        case .serverError: return "Our servers are having a rough day. Please try again in a little while."
        case .unknownError: return "Something went sideways. Our team is on it — please try again."
        }
    }

    private static func userMsg(forStatusCode code: Int) -> String {
        switch code {
        case 400: return "That request didn't make sense to the server. Please try again."
        case 401: return unauthorized.baseUserMsg
        case 403: return "You don't have access to this."
        case 404: return notFound.baseUserMsg
        case 408: return "The request took too long. Please try again."
        case 418: return "The server refused to brew coffee. Try asking for something else."
        case 429: return rateLimited.baseUserMsg
        case 500: return "The server tripped over itself. Please try again."
        case 502, 504: return "The server went quiet mid-conversation. Please try again."
        case 503: return "The server is catching its breath. Please try again shortly."
        case 500 ... 599: return serverError(code: code).baseUserMsg
        default: return "Oops, something went wrong. Please try again."
        }
    }

    var serverMsg: String {
        switch self {
        case .invalidData: return "ERR: Invalid data"
        case .jsonParserError: return "ERR: Return failed to parse json data"
        case let .decodingError(error): return "ERR: Failed to decode json data \(error)"
        case let .requestFailed(description): return "ERR: Request failed \(description)"
        case let .invalidStatusCode(code): return "ERR: Invalid status code \(code)"
        case .urlBuildingFailed: return "ERR: Failed to build URL"
        case .noInternetConnection: return "ERR: No internet connection"
        case .unauthorized: return "ERR: Unauthorized (401)"
        case .notFound: return "ERR: Not found (404)"
        case .rateLimited: return "ERR: Rate limited (429)"
        case let .serverError(code): return "ERR: Server error \(code)"
        case let .unknownError(error): return "ERR: Unknow error occured \(error.localizedDescription)"
        }
    }
}
