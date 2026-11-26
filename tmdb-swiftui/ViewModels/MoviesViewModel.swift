import Combine

final class MoviesViewModel {
    var list: [Movie] = []

    private let service: MovieServiceProtocol

    init(service: MovieServiceProtocol) {
        self.service = service
    }

    func loadMovies() async {
        do {
            self.list = try await service.fetchMovies()
        } catch {
            print("ERR: unable to load movies \(error): VM")
        }
    }
}
