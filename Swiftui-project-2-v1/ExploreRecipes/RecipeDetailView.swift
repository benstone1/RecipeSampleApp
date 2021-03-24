//
//  RecipeDetailView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeDetailView: View {
    @State var isPresenting = false
    @Binding var recipe: Recipe
    
    var body: some View {
        VStack {
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    if recipe.ingredients.isEmpty {
                        Text("No Ingredients")
                            .padding()
                    } else {
                        ForEach(recipe.ingredients) { ingredient in
                            Text(ingredient.description)
                        }
                    }
                }
                Section(header: Text("Directions")) {
                    if recipe.directions.isEmpty {
                        Text("No Directions")
                            .padding()
                    } else {
                        ForEach(recipe.directions.indices, id: \.self) { index in
                            Text("\(index + 1). ").bold() + Text(recipe.directions[index].description)
                        }
                    }
                }
            }
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar(content: {
            ToolbarItem {
                Button("Edit") {
                    isPresenting = true
                }
            }
            // https://stackoverflow.com/questions/64405106/toolbar-is-deleting-my-back-button-in-the-navigationview
            ToolbarItem(placement: .navigationBarLeading) { Text("") }
        })
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe, style: .edit)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            isPresenting = false
                        }
                    }
                }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.emptyRecipe
    static var previews: some View {
        RecipeDetailView(recipe: $recipe)
    }
}

