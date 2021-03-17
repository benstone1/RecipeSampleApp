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
    let directions: [String]
    
    static let allRecipes: [Recipe] = [
        Recipe(name: "Apple Pie",
               ingredients: [
                Ingredient(name: "Apple", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 1, unit: .cups)
               ],
               description: "It's great!",
               directions: ["Combine", "Bake"]),
        Recipe(name: "Banana Bread",
               ingredients: [
                Ingredient(name: "Banana", quantity: 5, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.5, unit: .cups),
                Ingredient(name: "Butter", quantity: 8, unit: .tbs),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               description: "Delicious!",
               directions: ["Combine", "Bake"]),
        Recipe(name: "Carrot Cake",
               ingredients: [
                Ingredient(name: "Carrot", quantity: 3, unit: .none),
                Ingredient(name: "Sugar", quantity: 0.75, unit: .cups),
                Ingredient(name: "Cream Cheese", quantity: 8, unit: .oz),
                Ingredient(name: "Flour", quantity: 1, unit: .cups)
               ],
               description: "Carroty!",
               directions: ["Combine all of the ingredients together.  Just as our ancestors did when originally gathering food from the harvest, now it your turn.", "Bake", "Add Frosting"]),
    ]
}

struct Ingredient: Identifiable {
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
                return "1 \(unit.rawValue) \(name)"
            } else {
                return "\(formattedQuanity) \(unit.pluralName) \(name) "
            }
        }
    }
    
    enum Unit: String, CaseIterable, Identifiable {
        var id: Unit { self }
        
        case oz = "Ounce"
        case g = "Gram"
        case cups = "Cup"
        case tbs = "Tablespoon"
        case tsp = "Teaspoon"
        case none = "No unit"
        var pluralName: String { self.rawValue + "s" }
    }
}


/*
 enum Volume: CustomStringConvertible {
     case cups(Double)
     case tbs(Double)
     case tsp(Double)
     
     var description: String {
         switch self {
         case let .cups(cupCount): return "\(cupCount) Cups"
         case let .tbs(tbsCount): return "\(tbsCount) Tablespoons"
         case let .tsp(tspCount): return "\(tspCount) Teaspoons"
         }
     }
 }
 
 enum Weight: CustomStringConvertible {
     case lbs(Double)
     case oz(Double)
     case g(Double)
     
     var description: String {
         switch self {
         case let .lbs(lbsCount): return "\(lbsCount) Pounds"
         case let .oz(ozCount): return "\(ozCount) Ounces"
         case let .g(gCount): return "\(gCount) Grams"
         }
     }
 }
 enum Quantity: CustomStringConvertible, CaseIterable {
     
     case oz(Double)
     case g(Double)
     case cups(Double)
     case tbs(Double)
     case tsp(Double)
     case number(Int)
     
     var description: String {
         switch self {
         case let .oz(weight): return "\(weight) Ounces"
         case let .g(gramCount): return "\(gramCount) Grams"
         case let .cups(cupCount): return "\(cupCount) Cups"
         case let .tbs(tbsCount): return "\(tbsCount) Tablespoons"
         case let .tsp(tspCount): return "\(tspCount) Teaspoons"
         case let .number(count): return "\(count)"
         }
     }
 }


 */
