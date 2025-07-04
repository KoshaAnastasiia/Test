import Foundation

class FeedPresenter: ObservableObject, FeedPresenterProtocol {
    weak var view: FeedViewProtocol?
    var interactor: FeedInteractorProtocol?
    var router: FeedRouter?

    @Published var users: [FeedUser] = []
    @Published var errorMessage: String? = nil

    func viewDidLoad() {
        interactor?.fetchUsers()
    }

    func didSelectUser(_ user: FeedUser, at index: Int) {
        if index == 0 {
            router?.showPaywall()
        } else {
            router?.navigateToUserProfile(user)
        }
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    func didFetchUsers(_ users: [FeedUser]) {
        self.users = users
        view?.showUsers(users)
    }

    func didFailToFetchUsers(error: Error) {
        self.errorMessage = error.localizedDescription
        view?.showError(error.localizedDescription)
    }
}
