//
//  IngredientsListView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/16/21.
//

import SwiftUI

struct IngredientsListView: View {
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            List(ingredients) { ingredient in
                Text(ingredient.description)
            }
        }
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView(ingredients: Recipe.allRecipes[0].ingredients)
    }
}
