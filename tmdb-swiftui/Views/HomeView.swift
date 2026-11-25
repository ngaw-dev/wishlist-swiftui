import SwiftUI

struct HomeView: View {
    @StateObject var movies = MoviesListViewModel()

    var body: some View {
        Text(movies.title)
            .font(.title)
        Text(movies.overview)
            .font(.title3)
        Text("overview")
        Text("poster")
        Text("genreIds")
        Text("releaseDate")
    }
}

#Preview {
    HomeView()
}
