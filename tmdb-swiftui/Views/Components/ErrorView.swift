// tmdb-swiftui/Views/Components/ErrorView.swift
import SwiftUI

/// Shared error display: first sentence as the headline, the rest as a
/// supporting line, plus a retry button when an action is provided.
struct ErrorView: View {
    let error: ApiError
    var retry: (() async -> Void)?

    private var sentences: [String] {
        error.userMsgSentences
    }

    var body: some View {
        ContentUnavailableView {
            Label(sentences.first ?? "Something went wrong.", systemImage: "exclamationmark.triangle")
        } description: {
            // Each remaining sentence gets its own line for easier reading.
            ForEach(Array(sentences.dropFirst().enumerated()), id: \.offset) { _, sentence in
                Text(sentence)
            }
        } actions: {
            if let retry {
                Button("Try Again") {
                    Task { await retry() }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ErrorView(error: .requestFailed(description: "Request timed out"))
}
