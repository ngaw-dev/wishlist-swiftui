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
            case .error(let errorMsg):
                Text(errorMsg)
            case .loaded(let list):
                Text("Loaded")
            }
        }
        .task {
            await moviesViewModel.loadMovies()
        }
//        .overlay {
//            if let error = movies.errorMessage {
//                Text(error)
//            }
//        }
        Text("overview")
        Text("poster")
        Text("genreIds")
        Text("releaseDate")
    }
}

#Preview {
    HomeView()
}
