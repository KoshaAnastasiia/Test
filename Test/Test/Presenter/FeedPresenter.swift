import Foundation

class FeedPresenter: ObservableObject, FeedPresenterProtocol {
    var interactor: FeedInteractorProtocol?
    var router: FeedRouterProtocol?

    @Published var users: [FeedUser] = []
    @Published var errorMessage: String? = nil

    func viewDidLoad() {
        interactor?.fetchUsers()
    }

    func didSelectUser(_ user: FeedUser, at index: Int) {
        if index == 0 {
            router?.showPaywallSheet()
        } else {
            router?.navigateToUserProfile(user)
        }
    }

    func didSelectUserChat(_ user: FeedUser) {
        router?.navigateToUserChat(user)
    }

    func didSelectUserVideo(_ user: FeedUser) {
        router?.navigateToUserVideo(user)
    }

    func didSelectUserFavourite(_ user: FeedUser) {
        router?.navigateToUserFavourite(user)
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    func didFetchUsers(_ users: [FeedUser]) {
        self.users = users
    }

    func didFailToFetchUsers(error: Error) {
        self.errorMessage = error.localizedDescription
    }
}
