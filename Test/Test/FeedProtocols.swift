import Foundation

protocol FeedViewProtocol: AnyObject {
    func showUsers(_ users: [FeedUser])
    func showError(_ message: String)
}

protocol FeedPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectUser(_ user: FeedUser, at index: Int)
}

protocol FeedInteractorProtocol: AnyObject {
    func fetchUsers()
}

protocol FeedInteractorOutputProtocol: AnyObject {
    func didFetchUsers(_ users: [FeedUser])
    func didFailToFetchUsers(error: Error)
}

protocol FeedRouterProtocol: AnyObject {
    func navigateToUserProfile(_ user: FeedUser)
} 