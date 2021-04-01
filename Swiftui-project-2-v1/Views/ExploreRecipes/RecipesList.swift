//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipesList: View {
    @EnvironmentObject var recipeData: RecipeData
    @State var isPresenting = false
    @State var newRecipe = Recipe.emptyRecipe
        
    let viewStyle: ViewStyle
        
    var body: some View {
        List {
            switch viewStyle {
            case .favorite:
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        CategoriesList(category: category, onlyFavorites: true)
                    }
                }
            case let .category(category):
                CategoriesList(category: category, onlyFavorites: false)
            }
        }
        .navigationBarTitle(viewStyle.navigationTitle)
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
                recipeData.recipes.append(newRecipe)
            }
        }
    }
    
    enum ViewStyle {
        case category(MainInformation.Category)
        case favorite
        
        var navigationTitle: String {
            switch self {
            case let .category(category): return "\(category.rawValue) Recipes"
            case .favorite: return "Favorite Recipes"
            }
        }
    }
}

struct CategoriesList: View {
    @EnvironmentObject var recipeData: RecipeData
    @AppStorage("color") var color: Color = .white

    let category: MainInformation.Category
    let onlyFavorites: Bool
        
    var body: some View {
        let recipes = recipeData.recipes(for: category, onlyFavorites: onlyFavorites)
        ForEach(recipes, id: \.id) { recipe in
            let index = recipeData.index(for: recipe)
            NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: $recipeData.recipes[index]))
        }
        .listRowBackground(color)
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
    static var recipeData: RecipeData = {
        let rd = RecipeData()
        rd.loadRecipes()
        return rd
    }()
    
    static var previews: some View {
        RecipesList(viewStyle: .category(.dessert))
            .environmentObject(recipeData)
    }
}
