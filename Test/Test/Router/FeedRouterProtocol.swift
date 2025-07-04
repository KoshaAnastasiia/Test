import Foundation

protocol FeedRouterProtocol: AnyObject {
    func navigateToUserProfile(_ user: FeedUser)
    func navigateToUserChat(_ user: FeedUser)
    func navigateToUserVideo(_ user: FeedUser)
    func navigateToUserFavourite(_ user: FeedUser)
    func back()
    func showPaywallSheet()
    func hidePaywallSheet()
}
