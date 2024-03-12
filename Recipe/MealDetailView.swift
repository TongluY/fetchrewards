import SwiftUI

struct MealDetailView: View {
    var mealID: String
    @ObservedObject var viewModel = MealDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let mealDetail = viewModel.mealDetail {
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    .frame(height: 200)
                    .clipped()
                    .padding(.bottom, 8)

                    Text(mealDetail.strMeal)
                        .font(.title2)
                        .padding(.horizontal)
                        .padding(.bottom, 2)

                    Text("Ingredients")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom, 2)

                    VStack(alignment: .leading) {
                        ForEach(0..<mealDetail.ingredients.count, id: \.self) { index in
                            HStack {
                                Text("• \(mealDetail.ingredients[index])")
                                Spacer()
                                Text(mealDetail.measurements[index])
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)

                    Text("Instructions")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom, 2)

                    Text(mealDetail.strInstructions)
                        .padding(.horizontal)
                } else {
                    Text("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Meal Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMealDetail(mealID: mealID)
        }
    }
}
