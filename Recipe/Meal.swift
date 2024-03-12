import Foundation

struct Meal: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    var id: String { idMeal }
}

struct MealList: Decodable {
    let meals: [Meal]
}

struct MealDetail: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    var ingredients: [String] = []
    var measurements: [String] = []
    
    var id: String { idMeal }
    
    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        ingredients = []
        measurements = []
        
        func decodeIfPresentAndNotEmpty(forKey key: CodingKeys) throws -> String? {
            if let value = try container.decodeIfPresent(String.self, forKey: key), !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return value
            }
            return nil
        }
        
     
        for i in 1...20 {
            if let ingredient = try decodeIfPresentAndNotEmpty(forKey: CodingKeys(rawValue: "strIngredient\(i)")!) {
                ingredients.append(ingredient)
            }
            if let measure = try decodeIfPresentAndNotEmpty(forKey: CodingKeys(rawValue: "strMeasure\(i)")!) {
                measurements.append(measure)
            }
        }
    }
}
