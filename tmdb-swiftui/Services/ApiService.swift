import Foundation

class ApiService {
    static func getRequest(apiUrl: String) -> URLRequest {
        let url = URL(string: "https://api.themoviedb.org/3/\(apiUrl)")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer " + Config.tmdbAccessToken,
        ]
        
        return request
    }
}
