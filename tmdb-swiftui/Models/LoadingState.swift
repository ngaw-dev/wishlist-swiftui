import Foundation

enum LoadingState<Value: Decodable> {
    case idle
    case loading
    case empty
    case error(String)
    case loaded(Value)
}
