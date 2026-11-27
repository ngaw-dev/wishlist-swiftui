import SwiftUI

struct PeopleView: View {
    @State private var peopleViewModel = PeopleViewModel(service: PeopleService())

    var body: some View {
        Group {
            switch peopleViewModel.loadingState {
            case .idle, .loading:
                ProgressView()
            case .empty:
                Text("No people found")
            case let .error(apiError):
                ErrorView(error: apiError)
            case let .loaded(list):
                PeopleListView(list: list)
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
