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
        NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: $recipe))
    }
}

struct RecipesList: View {
    @AppStorage("color") var color: Color = .green
    @Binding var recipes: [Recipe]
    @State var isPresenting = false
    @State var newRecipe = Recipe.emptyRecipe
    let category: MainInformation.Category
    
    var body: some View {
        VStack {
            List(recipes.filter { $0.mainInformation.category == category }) { recipe in
                let index = recipes.firstIndex { recipe.id == $0.id }!
                RecipeView(recipe: $recipes[index])
            }
        }
        .navigationBarTitle("Recipes")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
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

struct ContentView_Previews: PreviewProvider {
    @State static var recipes = Recipe.allRecipes
    static var previews: some View {
        RecipesList(recipes: $recipes, category: .dessert)
    }
}
