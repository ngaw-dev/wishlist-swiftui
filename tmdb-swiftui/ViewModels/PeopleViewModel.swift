import Foundation

@Observable
final class PeopleViewModel {
    var list: [People] = []

    func loadPeoples() async {
        self.list = People.mockPeople
    }
}
