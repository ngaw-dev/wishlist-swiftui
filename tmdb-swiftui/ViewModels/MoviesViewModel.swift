import Combine
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var list = [Movie]()
    
    private let service = MoviesService()
    
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
                self.list = movies
            }
        }
    }
}
