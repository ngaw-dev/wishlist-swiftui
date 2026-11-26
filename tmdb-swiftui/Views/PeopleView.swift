import SwiftUI

struct PeopleView: View {
    @State private var peopleViewModel = PeopleViewModel(service: PeopleService())

    var body: some View {
        List {
            ForEach(peopleViewModel.list) { person in
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
        .task {
            await peopleViewModel.loadPeoples()
        }
    }
}

#Preview {
    PeopleView()
}
