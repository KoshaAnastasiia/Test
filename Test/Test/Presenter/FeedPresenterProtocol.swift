import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectUser(_ user: FeedUser, at index: Int)
    func didSelectUserChat(_ user: FeedUser)
    func didSelectUserVideo(_ user: FeedUser)
    func didSelectUserFavourite(_ user: FeedUser)
}
