import Foundation

class FeedRepository: FeedInteractorProtocol {
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
                            status: FeedUser.Status(rawValue: json.status) ?? .offline
                        )
                    }
                    self?.output?.didFetchUsers(users)
                case .failure(let error):
                    self?.output?.didFailToFetchUsers(error: error)
                }
            }
        }
    }
}
