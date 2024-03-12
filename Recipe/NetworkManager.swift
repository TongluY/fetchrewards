import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    func fetchDessertMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let endpoint = "\(baseURL)/filter.php?c=Dessert"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let mealList = try JSONDecoder().decode(MealList.self, from: data)
                completion(.success(mealList.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMealDetails(mealID: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        let endpoint = "\(baseURL)/lookup.php?i=\(mealID)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let mealDetail = response.meals.first {
                    completion(.success(mealDetail))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
}


struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}

