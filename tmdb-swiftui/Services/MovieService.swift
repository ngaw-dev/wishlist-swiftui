import Foundation

protocol MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie]
}

struct MovieService: MovieServiceProtocol {
    private var client: ApiClient

    init() {
        client = ApiClient()
    }

    func fetchMovies() async throws -> [Movie] {
        try await client.execute(apiUrl: "/trending/movie/day", as: MoviesListResult.self).results
    }
}

struct MockMovieService: MovieServiceProtocol {
    func fetchMovies() async throws -> [Movie] {
        return Movie.mockMovies
    }
}
