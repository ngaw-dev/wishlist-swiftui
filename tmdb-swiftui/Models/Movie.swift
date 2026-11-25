import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let poster: String?
    //    let genreIds: [Int]
    let releaseDate: String
}

struct MoviesList: Codable {
    let results: [Movie]
}
