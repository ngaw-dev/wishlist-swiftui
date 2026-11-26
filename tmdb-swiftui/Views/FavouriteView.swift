// tmdb-swiftui/Views/FavouriteView.swift
import SwiftUI

struct FavouriteView: View {
    var body: some View {
        // system navigation bars always inset the title, so a plain
        // header is used to keep it flush with the top of the page
        HStack {
            Text("Favourites")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Button("", systemImage: "arrow.up", action: { print("test") })
        }
        Text("Content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    FavouriteView()
}
