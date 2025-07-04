import Foundation

class FeedInteractor: FeedInteractorProtocol {
    weak var output: FeedInteractorOutputProtocol?

    func fetchUsers() {
        let users = [
            FeedUser(name: "Anita", age: 18, countryFlag: "🇪🇸", imageUrl: "anita.jpg", status: .online),
            FeedUser(name: "Samanta", age: 25, countryFlag: "🇪🇸", imageUrl: "samanta.jpg", status: .offline),
            FeedUser(name: "Carmen", age: 32, countryFlag: "🇪🇸", imageUrl: "carmen.jpg", status: .recently),
            FeedUser(name: "Soldead", age: 23, countryFlag: "🇪🇸", imageUrl: "soldead.jpg", status: .online)
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.output?.didFetchUsers(users)
        }
    }
} 
