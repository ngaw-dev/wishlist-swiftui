import Foundation

protocol PeopleServiceProtocol {
    func fetchPeople() async throws -> [People]
}

struct PeopleService: PeopleServiceProtocol {
    private var client: ApiClient

    init() {
        client = ApiClient()
    }

    func fetchPeople() async throws -> [People] {
        try await client.execute(apiUrl: "/trending/person/day", as: PeopleListResult.self).results
    }
}

struct MockPeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        return People.mockPeople
    }
}
