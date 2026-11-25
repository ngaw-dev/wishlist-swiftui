import SwiftUI

struct HomeView: View {
    @StateObject var movies = MoviesViewModel()

    var body: some View {
        List {
            ForEach(movies.list) { movie in
                Text(movie.title)
                Text(movie.overview)
                    .font(.caption2)
            }
        }
        .overlay {
            if let error = movies.errorMessage {
                Text(error)
            }
        }
        Text("overview")
        Text("poster")
        Text("genreIds")
        Text("releaseDate")
    }
}

#Preview {
    HomeView()
}
