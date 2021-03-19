//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipesList: View {
    @AppStorage("recipes") var recipes: [Recipe] = Recipe.allRecipes
    
    var body: some View {
        NavigationView {
            VStack {
                List(recipes) { recipe in
                    NavigationLink(recipe.name,
                                   destination: RecipeDetailView(recipe: recipe))
                }
            }
            .navigationBarTitle("Recipes")
            .toolbar(content: {
                NavigationLink("New Recipe", destination: CreateRecipeView { newRecipe in
                    recipes.append(newRecipe)
                })
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesList()
    }
}
