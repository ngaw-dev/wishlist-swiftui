import Foundation

@Observable
final class MoviesViewModel {
    var loadingState: LoadingState<[Movie]> = .idle

    private let service: MovieServiceProtocol

    init(service: MovieServiceProtocol) {
        self.service = service
    }

    func loadMovies() async {
        loadingState = .loading

        do {
            let list = try await service.fetchMovies()
            loadingState = list.isEmpty ? .empty : .loaded(list)
        } catch {
            let apiError = (error as? ApiError) ?? .unknownError(error: error)
            loadingState = .error(apiError)
            print("ERR: unable to load movies \(apiError.serverMsg): VM")
        }
    }
}
