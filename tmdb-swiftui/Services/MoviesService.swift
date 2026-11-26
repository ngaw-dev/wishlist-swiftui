import Foundation

class MoviesService {
    private var url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")!

    func getRequest() -> URLRequest {
        var components = URLComponents(url: self.url, resolvingAgainstBaseURL: true)!
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

    func fetchMoviesList() async throws -> [Movie] {
        let (data, response) = try await URLSession.shared.data(for: self.getRequest())

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Request failed")
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.invalidaStatusCode(code: httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(MoviesList.self, from: data).results
        } catch {
            print("Parse error:", error)
            throw ApiError.jsonParserError
        }
    }
}

extension MoviesService {
    func fetchMoviesList(completion: @escaping (Result<[Movie], ApiError>) -> Void) {
        URLSession.shared.dataTask(with: self.getRequest()) { data, response, error in
            if let error = error {
                print("ERR: error occured \(error.localizedDescription)")
                completion(.failure(.unknownError(error: error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidaStatusCode(code: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let response = try decoder.decode(MoviesList.self, from: data)
                let moviesList: [Movie] = response.results

                print("SRV: movies list fetched")
                completion(.success(moviesList))
            } catch {
                print("Parse error:", error)
                completion(.failure(.jsonParserError))
            }
        }.resume()
    }
}
