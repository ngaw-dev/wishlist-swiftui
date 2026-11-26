import Foundation

struct ApiClient {
    var session: URLSession = .shared
    var decoder: JSONDecoder = JSONDecoder()

    static func getRequest(apiUrl: String) -> URLRequest {
        let url = URL(string: "https://api.themoviedb.org/3/\(apiUrl)")!

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer " + Config.tmdbAccessToken,
        ]

        return request
    }

    func execute<Response: Decodable>(apiUrl: String, as _: Response.Type) async throws -> Response {
        let request = Self.getRequest(apiUrl: apiUrl)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Request failed")
        }

        guard (200 ... 299).contains(httpResponse.statusCode) else {
            throw ApiError.invalidaStatusCode(code: httpResponse.statusCode)
        }

        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            print("Parse error:", error)
            throw ApiError.jsonParserError
        }
    }
}
