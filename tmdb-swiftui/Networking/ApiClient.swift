import Foundation

struct ApiClient {
    var session: URLSession = .shared
    var decoder: JSONDecoder = JSONDecoder()

    static func getRequest(apiUrl: String) -> URLRequest? {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(apiUrl)") else { return nil }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        // Copy queryItems out first: reading and mutating `components`
        // in one expression trips Swift's exclusivity checking.
        let existingItems = components?.queryItems ?? []
        components?.queryItems = existingItems + queryItems

        guard let finalUrl = components?.url else { return nil }
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer " + Config.tmdbAccessToken,
        ]

        return request
    }

    func execute<Response: Decodable>(apiUrl: String, as _: Response.Type) async throws -> Response {
        do {
            guard let request = Self.getRequest(apiUrl: apiUrl) else {
                throw ApiError.urlBuildingFailed
            }

            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.requestFailed(description: "Response was not HTTP")
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                throw ApiErrorMapper.map(statusCode: httpResponse.statusCode)
            }

            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(Response.self, from: data)
        } catch let error as ApiError {
            // Already typed — rethrow untouched.
            throw error
        } catch let urlError as URLError {
            throw ApiErrorMapper.map(error: urlError)
        } catch {
            throw ApiErrorMapper.mapDecodingError(error)
        }
    }
}
