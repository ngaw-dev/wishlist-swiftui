import Combine
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var moviesList = [Movie]()
    
    private let service = MoviesListService()
    
    init() {
        fetchMoviesList()
    }
    
    func fetchMoviesList() {
        service.fetchMoviesList { movies in
            DispatchQueue.main.async {
                print("VM: fetch movies completed")
                for movie in movies {
                    print("VM: \(movie.title)")
                }
                self.moviesList = movies
            }
        }
    }
}
