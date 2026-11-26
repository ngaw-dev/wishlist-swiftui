import Foundation

struct ApiRequest {
    func getRequest(apiUrl: String) -> URLRequest {
        let url = URL(string: "https://api.themoviedb.org/3/\(apiUrl)")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US")
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
    
    func execute<Response>(_, requestModel: ApiRequest<Response>) async throws -> Response {
        let apiRequest = ApiService.getRequest(apiUrl: "/trending/person/day")
        let (data, response) = try await URLSession.shared.data(for: apiRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Request failed")
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.invalidaStatusCode(code: httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(Response.self, from: data).results
        } catch {
            print("Parse error:", error)
            throw ApiError.jsonParserError
        }
    }
}
