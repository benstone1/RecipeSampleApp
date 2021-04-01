//
//  Contact.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    var isFavorite = false
    
    
    static let emptyRecipe = Recipe(mainInformation: MainInformation(name: "", description: "", category: .breakfast),
                                    ingredients: [],
                                    directions: [])
}

struct MainInformation: Codable, Identifiable {
    var id = UUID()
    
    var name: String
    var description: String
    var category: Category
    
    enum Category: String, CaseIterable, Identifiable, Codable {
        var id: Category { self }
        
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}

struct Direction: Identifiable, CustomStringConvertible, Codable, EmptyInitializable {
    var id = UUID()
    
    init(_ description: String, isRequired: Bool = true) {
        self.description = description
        self.isRequired = true
    }
    init() {
        self.description = ""
        self.isRequired = true
    }
    var description: String
    var isRequired: Bool
}

struct Ingredient: Identifiable, CustomStringConvertible, Codable, EmptyInitializable {
    var id = UUID()
    var name: String
    var quantity: Double
    var unit: Unit
    init(name: String, quantity: Double, unit: Unit) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
    
    init() {
        self.name = ""
        self.quantity = 1
        self.unit = .none
    }
    
    var description: String {
        let formattedQuanity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name : "\(name)s"
            return "\(formattedQuanity) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) \(name)"
            } else {
                return "\(formattedQuanity) \(unit.rawValue) \(name) "
            }
        }
    }
    
    enum Unit: String, CaseIterable, Identifiable, Codable {
        var id: Unit { self }
        
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No units"
        var singularName: String { String(rawValue.dropLast()) }
    }
}


extension Recipe {
    static let testRecipes: [Recipe] = [
        Recipe(mainInformation: MainInformation(name: "Apple Pie", description: "It's great!", category: .dessert),
               ingredients: [
                Ingredient(name: "Apple", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 1, unit: .cups)
               ],
               directions: [
                Direction("Combine"),
                Direction("Bake")
               ]),
        Recipe(mainInformation: MainInformation(name: "Banana Bread", description: "Delicious!", category: .dessert),
               ingredients: [
                Ingredient(name: "Banana", quantity: 5, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.5, unit: .cups),
                Ingredient(name: "Butter", quantity: 8, unit: .tbs),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               directions: [
                Direction("Combine"),
                Direction("Bake")
               ]),
        Recipe(mainInformation: MainInformation(name: "Beef Wellington", description: "Beefy!", category: .dinner),
               ingredients: [
                Ingredient(name: "Beef", quantity: 5, unit: .none),
                Ingredient(name: "Wellington", quantity: 1, unit: .cups),
               ],
               directions: [
                Direction("Combine"),
                Direction("Bake")
               ]),
        Recipe(mainInformation: MainInformation(name: "Carrot Cake", description: "Carroty!", category: .dessert),
               ingredients: [
                Ingredient(name: "Carrot", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.75, unit: .cups),
                Ingredient(name: "Cream Cheese", quantity: 8, unit: .oz),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               directions: [
                Direction("Combine all of the ingredients together.  Just as our ancestors did when originally gathering food from the harvest, now it your turn."),
                Direction("Bake"),
                Direction("Add Frosting")
               ]),
    ]
}
