// tmdb-swiftui/Models/People.swift

import Foundation

struct People: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let profilePath: String
    let gender: Int
    let knownForDepartment: String
}

extension People {
    static let mockPeople: [People] = [
        People(
            id: 1,
            name: "Tom Hanks",
            profilePath: "/xndWKyTyAkyBlsdsdf4Z9.jpg",
            gender: 2,
            knownForDepartment: "Acting"
        ),
        People(
            id: 2,
            name: "Meryl Streep",
            profilePath: "/mndWKyTyAkyBlsdsdf4Z9.jpg",
            gender: 1,
            knownForDepartment: "Acting"
        ),
        People(
            id: 3,
            name: "Leonardo DiCaprio",
            profilePath: "/lndWKyTyAkyBlsdsdf4Z9.jpg",
            gender: 2,
            knownForDepartment: "Acting"
        ),
        People(
            id: 4,
            name: "Emma Stone",
            profilePath: "/endWKyTyAkyBlsdsdf4Z9.jpg",
            gender: 1,
            knownForDepartment: "Acting"
        ),
        People(
            id: 5,
            name: "Christopher Nolan",
            profilePath: "/cndWKyTyAkyBlsdsdf4Z9.jpg",
            gender: 2,
            knownForDepartment: "Directing"
        ),
    ]
}
