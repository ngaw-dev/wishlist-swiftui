import Foundation

enum ApiError: Error {
    case invalidData
    case jsonParserError
    case requestFailed(description: String)
    case invalidaStatusCode(code: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData: return "ERR: Invalid data"
        case .jsonParserError: return "ERR: Return failed to parse json data"
        case let .requestFailed(description): return "ERR: Request failed \(description)"
        case let .invalidaStatusCode(code): return "ERR: Invalid status code \(code)"
        case let .unknownError(error): return "ERR: Unknow error occured \(error.localizedDescription)"
        }
    }
}
