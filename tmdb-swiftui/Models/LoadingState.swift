// tmdb-swiftui/Models/LoadingState.swift
import Foundation

enum LoadingState<Value: Decodable> {
    case idle
    case loading
    case empty
    case error(ApiError)
    case loaded(Value)
}
