import Foundation

class FeedInteractor: FeedInteractorProtocol {
    weak var output: FeedInteractorOutputProtocol?
    let service = FeedService()

    func fetchUsers() {
        service.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let jsonUsers):
                    let users: [FeedUser] = jsonUsers.compactMap { json in
                        FeedUser(
                            name: json.name,
                            age: json.age,
                            countryFlag: json.countryFlag,
                            imageUrl: json.imageUrl,
                            status: FeedInteractor.statusFromString(json.status)
                        )
                    }
                    self?.output?.didFetchUsers(users)
                case .failure(let error):
                    self?.output?.didFailToFetchUsers(error: error)
                }
            }
        }
    }

    private static func statusFromString(_ str: String) -> UserStatus {
        switch str.lowercased() {
        case "online": return .online
        case "offline": return .offline
        case "recently": return .recently
        default: return .offline
        }
    }
} 
