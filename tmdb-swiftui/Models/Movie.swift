import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
}

struct MoviesList: Codable {
    let results: [Movie]
}
extension Movie {
    static let mockMovies: [Movie] = [
        Movie(
            id: 1,
            title: "Inception",
            overview: "A thief who steals corporate secrets through dream-sharing technology.",
            posterPath: "/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg",
            releaseDate: "2010-07-16"
        ),
        Movie(
            id: 2,
            title: "The Dark Knight",
            overview: "Batman faces the Joker, a criminal mastermind who plunges Gotham into chaos.",
            posterPath: "/qJ2tW6WMUDux911r6mrcgGdS.jpg",
            releaseDate: "2008-07-18"
        ),
        Movie(
            id: 3,
            title: "Interstellar",
            overview: "A team of explorers travel through a wormhole in space in an attempt to save humanity.",
            posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
            releaseDate: "2014-11-07"
        ),
    ]
}

