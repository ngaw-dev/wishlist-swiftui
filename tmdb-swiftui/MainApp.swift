import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("", systemImage: "house") {
                    HomeView()
                }
                Tab("", systemImage: "person.3.sequence") {
                    PeopleView()
                }
                Tab("", systemImage: "heart") {
                    FavouriteView()
                }
                Tab("", systemImage: "magnifyingglass") {
                    SearchView()
                }
                Tab("", systemImage: "person.crop.circle") {
                    ProfileView()
                }
            }
        }
    }
}
