import Foundation

@Observable
final class PeopleService {
    var peoples: [People] = []
    
    func loadPeoples() async {
        self.peoples = People.mockPeople
    }
}

