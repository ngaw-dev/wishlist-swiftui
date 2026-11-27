import SwiftUI

struct PeopleListView: View {
    let list: [People]
    
    var body: some View {
        List(list) { person in
            VStack(alignment: .leading) {
                Text(person.name)
                if person.gender == 1 {
                    Text("Female")
                } else if person.gender == 2 {
                    Text("Male")
                } else {
                    Text("Unkown")
                }
                Text(person.knownForDepartment)
            }
        }
    }
}

#Preview {
    PeopleListView(list: People.mockPeople)
}
