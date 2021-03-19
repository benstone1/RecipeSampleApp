//
//  RecipeDetailView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var isPresenting = false
    let recipe: Recipe
    let onEdit: (Recipe) -> Void
    
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
                        Text("\(i+1). ").bold() + Text(recipe.directions[i].description)
                    }
                }
            }
        }
        .navigationTitle(recipe.name)
        .toolbar(content: {
            ToolbarItem {
                Button("Edit") {
                    isPresenting = true
                }
            }
        })
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                CreateRecipeView(name: recipe.name,
                                 description: recipe.description,
                                 ingredients: recipe.ingredients,
                                 directions: recipe.directions) { (newRecipe) in
                    onEdit(newRecipe)
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe.allRecipes[0], onEdit: { _ in return })
    }
}

