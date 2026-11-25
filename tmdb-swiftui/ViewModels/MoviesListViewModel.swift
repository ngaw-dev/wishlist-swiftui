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

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Recevied data \(data)")
        }.resume()
    }
}
