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
                Text(recipe.description)
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
                        ForEach(Array(recipe.ingredients.enumerated()), id: \.1) { index, ingredient in
                            Text(ingredient.description)
                        }
                    }
                }
                Section(header: Text("Directions")) {
                    if recipe.directions.isEmpty {
                        Text("No Directions")
                            .padding()
                    } else {
                        ForEach(Array(recipe.directions.enumerated()), id: \.1) { index, direction in
                            Text("\(index + 1). ").bold() + Text(direction.description)
                        }
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
    static var previews: some View {
        Circle()
    }
}

