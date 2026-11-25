import SwiftUI

struct HomeView: View {
    @StateObject var movies = MoviesListViewModel()

    var body: some View {
        Text("title")
        Text("overview")
        Text("poster")
        Text("genreIds")
        Text("releaseDate")
    }
}

#Preview {
    HomeView()
}
