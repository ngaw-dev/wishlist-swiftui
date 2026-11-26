import Foundation

protocol PeopleServiceProtocol {
    func fetchPeople() async throws -> [People]
}

struct PeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        let apiRequest = ApiService.getRequest(apiUrl: "/trending/person/day")
        let (data, response) = try await URLSession.shared.data(for: apiRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.requestFailed(description: "Request failed")
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.invalidaStatusCode(code: httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            return try decoder.decode(PeopleList.self, from: data).results
        } catch {
            print("Parse error:", error)
            throw ApiError.jsonParserError
        }
    }
}

struct MockPeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        return People.mockPeople
    }
}
