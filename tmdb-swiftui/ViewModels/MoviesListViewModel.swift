import Combine
import Foundation

class MoviesListViewModel: ObservableObject {

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
    }
}
