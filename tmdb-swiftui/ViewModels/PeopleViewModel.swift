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
            list = try await service.fetchPeople()
        } catch {
            print("ERR: unable to load peoples \(error): VM")
        }
    }
}
