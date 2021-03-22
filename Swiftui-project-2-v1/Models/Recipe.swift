//
//  Contact.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    var name: String
    var ingredients: [Ingredient]
    var description: String
    var directions: [Direction]
    
    static let emptyRecipe = Recipe(name: "", ingredients: [], description: "", directions: [])
    
    static let allRecipes: [Recipe] = [
        Recipe(name: "Apple Pie",
               ingredients: [
                Ingredient(name: "Apple", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 1, unit: .cups)
               ],
               description: "It's great!",
               directions: [
                Direction("Combine"),
                Direction("Bake")
               ]),
        Recipe(name: "Banana Bread",
               ingredients: [
                Ingredient(name: "Banana", quantity: 5, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.5, unit: .cups),
                Ingredient(name: "Butter", quantity: 8, unit: .tbs),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               description: "Delicious!",
               directions: [
                Direction("Combine"),
                Direction("Bake")
               ]),
        Recipe(name: "Carrot Cake",
               ingredients: [
                Ingredient(name: "Carrot", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.75, unit: .cups),
                Ingredient(name: "Cream Cheese", quantity: 8, unit: .oz),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               description: "Carroty!",
               directions: [
                Direction("Combine all of the ingredients together.  Just as our ancestors did when originally gathering food from the harvest, now it your turn."),
                Direction("Bake"),
                Direction("Add Frosting")
               ])
    ]
}

struct Direction: Identifiable, CustomStringConvertible, Codable, Hashable, EmptyInitializable {
    var id = UUID()
    init(_ description: String, isRequired: Bool = true) {
        self.description = description
        self.isRequired = true
    }
    init() {
        self.description = ""
        self.isRequired = true
    }
    let description: String
    let isRequired: Bool
}

struct Ingredient: Identifiable, CustomStringConvertible, Codable, Hashable, EmptyInitializable {
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
