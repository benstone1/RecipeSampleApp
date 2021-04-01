//
//  RecipeDetailView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeDetailView: View {
    @AppStorage("color") var color: Color = .white
    @AppStorage("hideOptionalSteps") var hideOptionalSteps: Bool = false
    @State var isPresenting = false
    @State var refresh = false
    
    @Binding var recipe: Recipe

    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            RecipeDetailInformationView(recipe: recipe, hideOptionalSteps: hideOptionalSteps)
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
                            .imageScale(.large)
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

struct RecipeDetailInformationView: View {
    @AppStorage("color") var color: Color = .white
    let recipe: Recipe
    let hideOptionalSteps: Bool
    
    var body: some View {
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
                        .listRowBackground(color)
                    }
                }
                Section(header: Text("Directions")) {
                    if recipe.directions.isEmpty {
                        Text("No Directions")
                            .padding()
                    } else {
                        DirectionsList(directions: recipe.directions, hideOptionalSteps: hideOptionalSteps)
                            .listRowBackground(color)
                    }
                }
            }
        }
    }
}

struct DirectionsList: View {
    let directions: [Direction]
    let hideOptionalSteps: Bool
    
    var body: some View {
        let filteredDirections = directions.filter { hideOptionalSteps ? $0.isRequired : true }
        ForEach(filteredDirections.indices, id: \.self) { index in
            let direction = directions[index]
            Text("\(index + 1). ").bold() + Text("\(direction.isRequired ? "" : "Optional: ")\(direction.description)")
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    
    static var previews: some View {
        RecipeDetailView(recipe: $recipe)
    }
}

