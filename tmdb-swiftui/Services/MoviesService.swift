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

    func fetchMoviesList(completion: @escaping(([Movie]) -> Void)) {
        URLSession.shared.dataTask(with: self.getRequest()) { data, response, error in
            if let error = error {
                print("ERR: error occured \(error.localizedDescription)")
            }

            guard let data = data else {
                print("ERR: no data returned")
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let response = try decoder.decode(MoviesList.self, from: data)
                let moviesList: [Movie] = response.results

                print("SRV: movies list fetched")
                completion(moviesList)
            } catch {
                print("Parse error:", error)
            }
        }.resume()
    }
}
