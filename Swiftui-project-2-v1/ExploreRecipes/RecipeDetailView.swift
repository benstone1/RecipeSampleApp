//
//  RecipeDetailView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            HStack {
                Text(recipe.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients) { ingredient in
                        Text(ingredient.description)
                    }
                }
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices) { i in
                        Text("\(i+1). \(recipe.directions[i])")
                    }
                }
            }
        }
        .navigationTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe.allRecipes[0])
    }
}

