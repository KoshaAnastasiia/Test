import Foundation

class FeedService {
    struct FeedUserJSON: Decodable {
        let name: String
        let age: Int
        let countryFlag: String
        let imageUrl: String
        let status: String
    }

    func fetchUsers(completion: @escaping (Result<[FeedUserJSON], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/c/cb53-9be5-4af7-a939") else {
            completion(.failure(NSError(domain: "FeedService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "FeedService", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                let users = try JSONDecoder().decode([FeedUserJSON].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
} 