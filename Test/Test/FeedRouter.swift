import Foundation
import SwiftUI

class FeedRouter: FeedRouterProtocol {
    func navigateToUserProfile(_ user: FeedUser) {
        print("Navigate to user profile: \(user.name)")
    }
} 
