import Foundation

@Observable
final class PeopleViewModel {
    var loadingState: LoadingState<[People]> = .idle

    private let service: PeopleServiceProtocol

    init(service: PeopleServiceProtocol) {
        self.service = service
    }

    func loadPeoples() async {
        loadingState = .loading

        do {
            let list = try await service.fetchPeople()
            loadingState = list.isEmpty ? .empty : .loaded(list)
        } catch {
            let apiError = (error as? ApiError) ?? .unknownError(error: error)
            loadingState = .error(apiError)
            print("ERR: unable to load peoples \(error): VM")
        }
    }
}
