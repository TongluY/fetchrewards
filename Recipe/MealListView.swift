import SwiftUI

struct MealListView: View {
    @ObservedObject var viewModel = MealListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    HStack {
                        if let imageUrl = URL(string: meal.strMealThumb) {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                            }
                        }
                        Text(meal.strMeal)
                            .padding(.leading, 8)
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchMeals()
            }
        }
    }
}
