import Foundation

class MoviesListService {
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

    func fetchMoviesList(completion: @escaping((String) -> Void)) {
        URLSession.shared.dataTask(with: self.getRequest()) { data, response, error in
            if let error = error {
                print("ERR: error occured \(error.localizedDescription)")
            }

            guard let data = data else {
                print("ERR: no data returned")
                return
            }

            do {
                guard let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let results  = jsonObj["results"] as? [[String: Any]]
                else {
                    print("Bad JSON structure")
                    return
                }

                if let firstMovie = results.first {
                    print(firstMovie["title"] ?? "")
                    if let title = firstMovie["title"] as? String {
                        print("SRV: Title in service class: \(title)")
                        completion(title)
                    }
                }

                print("Third movie: \(String(describing: results[2]["title"]))")
            } catch {
                print("Parse error:", error)
            }
        }.resume()
    }
}
