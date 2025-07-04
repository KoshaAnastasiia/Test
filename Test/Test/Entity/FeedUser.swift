import Foundation

struct FeedUser: Identifiable {
    enum Status: String {
        case online, offline, recently
    }

    let id: UUID = UUID()
    let name: String
    let age: Int
    let countryFlag: String
    let imageUrl: String
    let status: Status
}
