//
//  RecipeDetailView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeDetailView: View {
    @AppStorage("color") var color: Color = .green
    @AppStorage("hideOptionalSteps") var hideOptionalSteps: Bool = false
    @State var isPresenting = false
    @Binding var recipe: Recipe
    @State var refresh = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(recipe.mainInformation.description)
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                .padding()
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
                            let directions = hideOptionalSteps ? recipe.directions.filter { $0.isRequired } : recipe.directions
                            ForEach(directions.indices, id: \.self) { index in
                                let direction = recipe.directions[index]
                                Text("\(index + 1). ").bold() + Text("\(direction.isRequired ? "" : "Optional: ")\(direction.description)")
                            }
                        }
                    }
                }
            }
            .navigationTitle(recipe.mainInformation.name)
            .toolbar(content: {
                ToolbarItem {
                    HStack {
                        Button(action: {
                            recipe.isFavorite.toggle()
                            refresh.toggle() // TODO: Remove this hack (The UI only updates every other time when navigating to the detail from the Favorites list
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                                .font(.title)
                        }
                        Button("Edit") {
                            isPresenting = true
                        }
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
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.allRecipes[0]
    
    static var previews: some View {
        RecipeDetailView(recipe: $recipe)
    }
}

