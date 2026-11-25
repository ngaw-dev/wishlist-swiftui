import Combine
import Foundation

class MoviesListViewModel: ObservableObject {
    let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")!

    @Published var title = ""
    @Published var overview = ""
    @Published var poster = ""
    //    @Published var genreIds: [Int] = []
    @Published var releaseDate = ""

    init(
        title: String = "", overview: String = "", poster: String = "", /*genreIds: [Int], */
        releaseDate: String = ""
    ) {
        self.title = title
        self.overview = overview
        self.poster = poster
        //        self.genreIds = genreIds
        self.releaseDate = releaseDate

        fetchMoviesList()
    }

    func fetchMoviesList() {
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

        URLSession.shared.dataTask(with: request) { data, response, error in
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
                        self.title = title
                    }
                    if let overview = firstMovie["overview"] as? String {
                        self.overview = overview
                    }
                }
                
                print("Third movie: \(String(describing: results[2]["title"]))")
            } catch {
                print("Parse error:", error)
            }
        }.resume()
    }
}
