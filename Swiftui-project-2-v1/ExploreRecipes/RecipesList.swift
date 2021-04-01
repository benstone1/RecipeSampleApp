//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipesList: View {
    @AppStorage("color") var color: Color = .green
    @EnvironmentObject var recipeData: RecipeData

    @State var isPresenting = false
    @State var newRecipe = Recipe.emptyRecipe
    
    enum ViewStyle {
        case category(MainInformation.Category)
        case favorite
    }
    
    let viewStyle: ViewStyle
    
    var filteredRecipes: [Recipe] {
        switch viewStyle {
        case let .category(category): return recipeData.recipes.filter { $0.mainInformation.category == category }
        case .favorite: return recipeData.recipes.filter { $0.isFavorite == true }
        }
    }
    
    var body: some View {
        List {
            switch viewStyle {
            case .favorite:
                FavoritesList()
            case let .category(category):
                CategoriesList(category: category)
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
                recipeData.recipes.append(newRecipe)
            }
        }
    }
        
    private var navigationTitleStr: String {
        switch viewStyle {
        case let .category(category): return "\(category.rawValue) Recipes"
        case .favorite: return "Favorite Recipes"
        }
    }
}

struct CategoriesList: View {
    @EnvironmentObject var recipeData: RecipeData
    
    let category: MainInformation.Category
    let onlyDisplayFavorites: Bool
    
    init(category: MainInformation.Category, onlyDisplayFavorites: Bool = false) {
        self.category = category
        self.onlyDisplayFavorites = onlyDisplayFavorites
    }
    
    var body: some View {
        ForEach(filteredRecipes, id: \.id) { recipe in
            let index = recipeData.index(for: recipe)
            NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: $recipeData.recipes[index]))
        }
    }
    
    private var filteredRecipes: [Recipe] {
        return recipeData.recipes.filter { (recipe) -> Bool in
            let categoryMatches = recipe.mainInformation.category == category
            let isFavoriteOrDisplayAllRecipes = !onlyDisplayFavorites || recipe.isFavorite
            return categoryMatches && isFavoriteOrDisplayAllRecipes
        }
    }
}

struct FavoritesList: View {
    var body: some View {
        ForEach(MainInformation.Category.allCases, id: \.self) { category in
            Section(header: Text(category.rawValue)) {
                CategoriesList(category: category, onlyDisplayFavorites: true)
            }
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
