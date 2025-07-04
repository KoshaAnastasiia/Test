import Foundation

enum UserStatus {
    case online, offline, recently
}

struct FeedUser: Identifiable {
    let id: UUID = UUID()
    let name: String
    let age: Int
    let countryFlag: String
    let imageUrl: String
    let status: UserStatus
} 