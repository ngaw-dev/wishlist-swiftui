import Foundation

class MoviesService {
    func getRequest() -> URLRequest{
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")!

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
            "Authorization":
                "Bearer " + Config.tmdbAccessToken,
        ]

        return request
    }

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
