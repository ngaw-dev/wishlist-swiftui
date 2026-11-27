import SwiftUI

struct MoviesListView: View {
    let movies: [Movie]

    var body: some View {
        List(movies) { movie in
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
//                Text("overview")
//                Text("poster")
//                Text("genreIds")
//                Text("releaseDate")
            }
        }
    }
}

#Preview {
    MoviesListView(movies: Movie.mockMovies)
}
