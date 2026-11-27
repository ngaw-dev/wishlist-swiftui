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
            loadingState = .error(error.localizedDescription)
            print("ERR: unable to load movies \(error): VM")
        }
    }
}
