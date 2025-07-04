import SwiftUI

enum UserStatus: String {
    case online, offline, recently
    
    var color: Color {
        switch self {
        case .online:
            return Color.green
        case .offline:
            return Color.gray
        case .recently:
            return Color.yellow
        }
    }
}

struct FeedUser: Identifiable {
    let id: UUID = UUID()
    let name: String
    let age: Int
    let countryFlag: String
    let imageUrl: String
    let status: UserStatus
} 
