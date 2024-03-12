import Foundation

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []

    func fetchMeals() {
        NetworkManager.shared.fetchDessertMeals { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self?.meals = meals
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
