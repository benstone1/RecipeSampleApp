//
//  CreateRecipeView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct CreateRecipeView: View {
    @State var selection = Selection.main
    @State var ingredients = [Ingredient]()
    
    var body: some View {
        VStack {
            Text("Create a New Recipe")
                .font(.title)
                .padding()
            Picker(selection: $selection, label: Text("Picker"), content: {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            })
            .pickerStyle(SegmentedPickerStyle.init())
            switch selection {
            case .main:
                RecipeMainInfoView()
            case .ingredients:
                AddIngredientsView(ingredients: $ingredients)
            case .directions: Text("D")
            }
            Spacer()
        }
    }
    
    enum Selection {
        case main
        case ingredients
        case directions
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView(ingredients: Recipe.allRecipes[0].ingredients)
        CreateRecipeView(ingredients: [])
    }
}
