//
//  AddIngredientsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/16/21.
//

import SwiftUI

struct AddIngredientsView: View {
    var viewModel = ViewModel()
    @Binding var ingredients: [Ingredient]
    @State var selectedUnit: Ingredient.Unit = .cups
    @State var ingredientName = ""
    @State var count = 0
    
    var body: some View {
        VStack {
            IngredientsListView(ingredients: ingredients)
            Stepper("Quantity: \(count)", value: $count)
                .padding()
            Picker("Type", selection: $selectedUnit) {
                ForEach(Ingredient.Unit.allCases) { unit in
                    Text(unit.rawValue)
                }
            }
            TextField("Apple", text: $ingredientName)
                .padding()
            Button("Add Ingredient") {
                // Add Ingredient
            }
        }
    }
}

extension AddIngredientsView {
    struct ViewModel {
        var ingredients = [Ingredient]()
        
    }
}

struct AddIngredientsView_Previews: PreviewProvider {
    @State static var ingredients = [Ingredient](Recipe.allRecipes[0].ingredients)

    static var previews: some View {
        AddIngredientsView(ingredients: $ingredients)
    }
}
