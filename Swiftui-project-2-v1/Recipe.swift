//
//  Contact.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    let name: String
    let ingredients: [Ingredient]
    let description: String
    let directions: [Direction]
    
    static let allRecipes: [Recipe] = [
        Recipe(name: "Apple Pie",
               ingredients: [
                Ingredient(name: "Apple", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 1, unit: .cups)
               ],
               description: "It's great!",
               directions: ["Combine", "Bake"].map(Direction.init)),
        Recipe(name: "Banana Bread",
               ingredients: [
                Ingredient(name: "Banana", quantity: 5, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.5, unit: .cups),
                Ingredient(name: "Butter", quantity: 8, unit: .tbs),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               description: "Delicious!",
               directions: ["Combine", "Bake"].map(Direction.init)),
        Recipe(name: "Carrot Cake",
               ingredients: [
                Ingredient(name: "Carrot", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.75, unit: .cups),
                Ingredient(name: "Cream Cheese", quantity: 8, unit: .oz),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               description: "Carroty!",
               directions: ["Combine all of the ingredients together.  Just as our ancestors did when originally gathering food from the harvest, now it your turn.", "Bake", "Add Frosting"].map(Direction.init)),
    ]
}

struct Direction: Identifiable, CustomStringConvertible {
    var id = UUID()
    init(_ description: String) {
        self.description = description
    }
    let description: String
    let isOptional: Bool = false
}

struct Ingredient: Identifiable, CustomStringConvertible {
    var id = UUID()
    let name: String
    let quantity: Double
    let unit: Unit
    
    
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
    
    enum Unit: String, CaseIterable, Identifiable {
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
