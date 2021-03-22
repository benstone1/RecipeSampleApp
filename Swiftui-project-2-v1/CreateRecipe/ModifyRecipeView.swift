//
//  CreateRecipeView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct ModifyRecipeView: View {

    @State var selection = Selection.main
    @Binding var recipe: Recipe
    
    let style: ViewStyle
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Picker"), content: {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                RecipeMainInfoView(name: $recipe.name, description: $recipe.description)
            case .ingredients:
                AddElementsView<Ingredient, AddNewIngredientView>(elements: $recipe.ingredients)
            case .directions:
                AddElementsView<Direction, AddNewDirectionView>(elements: $recipe.directions)
            }
            Spacer()
        }
        .navigationTitle(style.navigationTitle)
    }
    
    enum Selection {
        case main
        case ingredients
        case directions
    }
    enum ViewStyle {
        case create
        case edit
        
        var navigationTitle: String {
            switch self {
            case .create: return "Add a New Recipe"
            case .edit: return "Edit Recipe"
            }
        }
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe.emptyRecipe
    
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe, style: .create)
        ModifyRecipeView(recipe: $recipe, style: .edit)
    }
}
