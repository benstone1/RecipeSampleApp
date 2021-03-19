//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipesList: View {
    @AppStorage("recipes") var recipes: [Recipe] = Recipe.allRecipes
    @State var isPresenting = false
        
    var body: some View {
        NavigationView {
            VStack {
                List(recipes) { recipe in
                    NavigationLink(recipe.name,
                                   destination: RecipeDetailView(recipe: recipe) { editedRecipe in
                                    return
//                                    let matchingIndex = recipes.firstIndex(where: { $0.id == editedRecipe.id })!
//                                    recipes[matchingIndex] = editedRecipe
                                   })
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
                    CreateRecipeView { newRecipe in
                        recipes.append(newRecipe)
                    }
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Dismiss") {
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
