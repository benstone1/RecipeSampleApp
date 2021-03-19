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
    
    var body: some View {
        VStack {
            let addIngredientView = AddNewIngredientView { ingredient in
                ingredients.append(ingredient)
            }
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient",
                               destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.description)
                    }
                    NavigationLink("Add another ingredient",
                                   destination: addIngredientView)
                        .foregroundColor(.blue)
                }
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
    @State static var emptyIngredients = [Ingredient]()


    static var previews: some View {
        AddIngredientsView(ingredients: $emptyIngredients)
        AddIngredientsView(ingredients: $ingredients)
    }
}
