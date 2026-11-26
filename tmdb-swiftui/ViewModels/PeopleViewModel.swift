import Foundation

@Observable
final class PeopleViewModel {
    var list: [People] = []
    
    private let service: PeopleServiceProtocol
    
    init(service: PeopleServiceProtocol) {
        self.service = service
    }

    func loadPeoples() async {
        do {
            self.list = try await service.fetchPeople()
        } catch {
            print("ERR: unable to load peoples \(error): VM")
        }
    }
}

protocol PeopleServiceProtocol {
    func fetchPeople() async throws -> [People]
}

struct PeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        return []
    }
}

struct MockPeopleService: PeopleServiceProtocol {
    func fetchPeople() async throws -> [People] {
        return People.mockPeople
    }
}
