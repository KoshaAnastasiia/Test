import Foundation

protocol FeedInteractorProtocol: AnyObject {
    func fetchUsers()
}

protocol FeedInteractorOutputProtocol: AnyObject {
    func didFetchUsers(_ users: [FeedUser])
    func didFailToFetchUsers(error: Error)
}
