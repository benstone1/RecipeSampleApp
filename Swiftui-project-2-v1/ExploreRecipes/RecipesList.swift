//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipesList: View {
    @AppStorage("color") var color: Color = .green
    @Binding var recipes: [Recipe]
    @State var isPresenting = false
    @State var newRecipe = Recipe.emptyRecipe
    
    enum ViewStyle {
        case category(MainInformation.Category)
        case favorite
    }

    let viewStyle: ViewStyle
    
    var filteredRecipes: [Recipe] {
        switch viewStyle {
        case let .category(category): return recipes.filter { $0.mainInformation.category == category }
        case .favorite: return recipes.filter { $0.isFavorite == true }
        }
    }
    
    var body: some View {
        VStack {
            List(filteredRecipes) { recipe in
                NavigationLink(recipe.mainInformation.name,
                               destination: RecipeDetailView(recipe: binding(for: recipe)))
            }
        }
        .navigationBarTitle(navigationTitleStr)
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
            AddRecipeSheetView(isPresenting: $isPresenting, recipe: $newRecipe) { newRecipe in
                recipes.append(newRecipe)
            }
        }
    }
    
    private func binding(for recipe: Recipe) -> Binding<Recipe> {
        let index = recipes.firstIndex { recipe.id == $0.id }!
        return $recipes[index]
    }
    
    private var navigationTitleStr: String {
        switch viewStyle {
        case let .category(category): return "\(category.rawValue) Recipes"
        case .favorite: return "Favorite Recipes"
        }
    }
}

struct AddRecipeSheetView: View {
    @Binding var isPresenting: Bool
    @Binding var recipe: Recipe
    var onAdd: (Recipe) -> Void
    
    var body: some View {
        NavigationView {
            ModifyRecipeView(recipe: $recipe, style: .create)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresenting = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            onAdd(recipe)
                            isPresenting = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var recipes = Recipe.allRecipes
    static var previews: some View {
        RecipesList(recipes: $recipes, viewStyle: .favorite)
    }
}
