import SwiftUI

struct MovieListItemView: View {
    @State private var list: [Movie] = []
    
    var body: some View {
        ForEach(list) { movie in
            Text(movie.title)
            Text(movie.overview)
                .font(.caption2)
        }
    }
}

#Preview {
    MovieListItemView()
}
