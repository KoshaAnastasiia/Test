import Foundation
import SwiftUI
import Combine

enum FeedRoute: Equatable {
    case profile(id: String)
    case chat(id: String)
    case video(id: String)
    case favourite(id: String)
}

enum FeedSheetRoute: Equatable, Identifiable {
    case paywall

    var id: String {
        switch self {
        case .paywall:
            "paywall"
        }
    }
}

class FeedRouter: ObservableObject, FeedRouterProtocol {
    @Published var route: FeedRoute? = nil
    @Published var isShowedPaywallSheet: Bool = false
    @Published var sheetRoute: FeedSheetRoute? = nil

    func showPaywallSheet() {
        sheetRoute = .paywall
    }

    func hidePaywallSheet() {
        sheetRoute = nil
    }

    func navigateToUserProfile(_ user: FeedUser) {
        print("Navigate to user profile: \(user.name)")
        route = .profile(id: user.id.uuidString)
    }

    func navigateToUserChat(_ user: FeedUser) {
        print("tap on \(user.name) chat")
        route = .profile(id: user.id.uuidString)
    }

    func navigateToUserVideo(_ user: FeedUser) {
        print("tap on \(user.name) video")
        route = .profile(id: user.id.uuidString)
    }

    func navigateToUserFavourite(_ user: FeedUser) {
        print("tap on \(user.name) favorite")
        route = .profile(id: user.id.uuidString)
    }

    func back() {
        route = nil
    }
}
