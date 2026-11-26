import SwiftUI

struct HomeView: View {
    @State private var moviesViewModel = MoviesViewModel(service: MovieService())

    var body: some View {
        List {
            ForEach(moviesViewModel.list) { movie in
                Text(movie.title)
                Text(movie.overview)
                    .font(.caption2)
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
