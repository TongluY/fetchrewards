import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?

    func fetchMealDetail(mealID: String) {
        NetworkManager.shared.fetchMealDetails(mealID: mealID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self?.mealDetail = detail
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
