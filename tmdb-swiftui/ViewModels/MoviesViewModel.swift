import Combine
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var list = [Movie]()
    @Published var errorMessage: String?
    
    private let service = MoviesService()
    
    init() {
        Task {
            self.list = try await fetcMoviesList()
        }
    }
    
    func fetcMoviesList() async throws {
        try await service.fetchMoviesList()
    }
    
    func fetchMoviesListViewModel() {
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
