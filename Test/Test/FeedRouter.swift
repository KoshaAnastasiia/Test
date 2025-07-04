import Foundation
import SwiftUI
import Combine

enum FeedRoute: Equatable {
    case paywall
}

class FeedRouter: ObservableObject, FeedRouterProtocol {
    @Published var route: FeedRoute? = nil
    @Published var isShowedPaywallSheet: Bool = false

    func showPaywall() {
        route = .paywall
    }

    func resetRoute() {
        route = nil
    }

    func showPaywallSheet() {
        isShowedPaywallSheet = true
    }

    func hidePaywallSheet() {
        isShowedPaywallSheet = false
    }

    func navigateToUserProfile(_ user: FeedUser) {
        print("Navigate to user profile: \(user.name)")
    }
} 
