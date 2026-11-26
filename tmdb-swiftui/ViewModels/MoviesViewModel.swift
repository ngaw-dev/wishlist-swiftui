import Combine
import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var list = [Movie]()
    @Published var errorMessage: String?

    private let service = MoviesService()

    init() {
        Task {
            await loadMovies()
        }
    }

    func loadMovies() async {
        do {
            self.list = try await fetchMoviesList()
        } catch {
            self.errorMessage = (error as? ApiError)?.customDescription ?? error.localizedDescription
        }
    }

    func fetchMoviesList() async throws -> [Movie] {
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
