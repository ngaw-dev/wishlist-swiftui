import Foundation

protocol MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie]
}

struct MovieService: MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie] {
        try await ApiRequest.execute(apiUrl: "/trending/movie/day", as: MoviesList.self).results
    }
}
struct MockMovieService: MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie] {
        return Movie.mockMovies
    }
}

