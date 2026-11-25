import Combine
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var list = [Movie]()
    @Published var errorMessage: String?
    
    private let service = MoviesService()
    
    init() {
        fetchMoviesList()
    }
    
    func fetchMoviesList() {
        service.fetchMoviesList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    print("VM: fetch movies completed")
                    for movie in movies {
                        print("VM: \(movie.title)")
                    }
                    self?.list = movies
                case .failure(let error):
                    self?.errorMessage = error.customDescription
                    print("VM: fetch movies failed:", error.customDescription)
                }
            }
        }
    }
}
