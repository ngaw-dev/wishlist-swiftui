import Foundation

protocol PeopleServiceProtocol {
    func fetchPeople() async throws -> [People]
}

struct PeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        try await ApiRequest.execute(apiUrl: "/trending/person/day", as: PeopleList.self).results
    }
}

struct MockPeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        return People.mockPeople
    }
}
