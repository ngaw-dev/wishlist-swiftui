// tmdb-swiftui/Config.swift
import Foundation

enum Config {
    /// read from Info.plist so the token isn't hardcoded in source
    static var tmdbAccessToken: String {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "TMDB_ACCESS_TOKEN") as? String else {
            fatalError("TMDB_ACCESS_TOKEN missing from Info.plist")
        }
        return token
    }
}
