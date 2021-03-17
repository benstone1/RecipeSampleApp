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
            Text(recipe.name)
                .font(.title)
                .padding()
                .foregroundColor(.green)
            HStack {
                Text(recipe.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            Text("Ingredients")
                .font(.title2)
                .padding()
            IngredientsListView(ingredients: recipe.ingredients)
            Text("Directions")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            ForEach(recipe.directions.indices) { index in
                HStack {
                    let str = "\(index + 1). \(recipe.directions[index])"
                    Text(str)
                    Spacer()
                }
                .padding()
            }
            Spacer()
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe.allRecipes[0])
    }
}
