import Foundation

class FeedService {
    enum ServiceError: Error {
        case invalidURL
        case responseNoData
    }

    struct FeedUserJSON: Decodable {
        let name: String
        let age: Int
        let countryFlag: String
        let imageUrl: String
        let status: String
    }

    func fetchUsers(completion: @escaping (Result<[FeedUserJSON], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/c/cb53-9be5-4af7-a939") else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ServiceError.responseNoData))
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

extension FeedService.ServiceError {
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .responseNoData:
            "Response has no data"
        }
    }
}
