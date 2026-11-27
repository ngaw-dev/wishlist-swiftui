import SwiftUI

struct HomeView: View {
    @State private var moviesViewModel = MoviesViewModel(service: MovieService())

    var body: some View {
        Group {
            switch moviesViewModel.loadingState {
            case .idle, .loading:
                ProgressView()
            case .empty:
                Text("Nothing to show")
            case let .error(error):
                ErrorView(error: error, retry: moviesViewModel.loadMovies)
            case let .loaded(list):
                MoviesListView(movies: list)
            }
        }
        .task {
            await moviesViewModel.loadMovies()
        }
    }
}

#Preview {
    HomeView()
}
