//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipeView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        NavigationLink(recipe.name, destination: RecipeDetailView(recipe: $recipe))
    }
}

struct RecipesList: View {
    @AppStorage("recipes") var recipes: [Recipe] = Recipe.allRecipes
    @State var isPresenting = false
    @State var newRecipe = Recipe.emptyRecipe
    
    var body: some View {
        NavigationView {
            VStack {
                List(recipes) { recipe in
                    let recipeIndex = recipes.firstIndex(where: { $0.id == recipe.id })!
                    RecipeView(recipe: $recipes[recipeIndex])
                }
            }
            .navigationBarTitle("Recipes")
            .toolbar(content: {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            })
            .sheet(isPresented: $isPresenting) {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe, style: .create)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                recipes.append(newRecipe)
                                isPresenting = false
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesList()
    }
}
