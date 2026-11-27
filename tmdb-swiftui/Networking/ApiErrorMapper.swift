import Foundation

/// Single place that converts raw URL/session failures into typed ApiErrors,
/// so ApiClient stays free of error-case knowledge.
enum ApiErrorMapper {
    /// Maps a non-2xx HTTP status to the most specific ApiError case.
    static func map(statusCode: Int) -> ApiError {
        switch statusCode {
        case 400: return .invalidStatusCode(code: statusCode)
        case 401: return .unauthorized
        case 404: return .notFound
        case 429: return .rateLimited
        case 500 ... 599: return .serverError(code: statusCode)
        default: return .invalidStatusCode(code: statusCode)
        }
    }

    /// Maps URLSession/decoding failures to ApiError, preserving the
    /// underlying error for logging.
    static func map(error: Error) -> ApiError {
        let nsError = error as NSError
        switch nsError.code {
        case NSURLErrorNotConnectedToInternet,
             NSURLErrorNetworkConnectionLost,
             NSURLErrorCannotConnectToHost:
            return .noInternetConnection
        case NSURLErrorTimedOut:
            return .requestFailed(description: "Request timed out")
        default:
            if let urlError = error as? URLError {
                return .requestFailed(description: urlError.localizedDescription)
            }
            return .unknownError(error: error)
        }
    }

    static func mapDecodingError(_ error: Error) -> ApiError {
        .decodingError(error: error)
    }
}
