import Foundation
import SwiftUI
import Combine

enum FeedRoute: Equatable {
    case paywall
}

class FeedRouter: ObservableObject, FeedRouterProtocol {
    @Published var route: FeedRoute? = nil

    func showPaywall() {
        route = .paywall
    }

    func resetRoute() {
        route = nil
    }

    func navigateToUserProfile(_ user: FeedUser) {
        print("Navigate to user profile: \(user.name)")
    }
} 
