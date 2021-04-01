//
//  RecipesListViewModel.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/26/21.
//

import SwiftUI

struct RecipesListViewModel {
    @AppStorage("recipes") private var allRecipes: [Recipe] = Recipe.allRecipes

    func filteredRecipes(from recipes: [Recipe]) -> [Recipe] {
        switch viewStyle {
        case let .category(category):
            return recipes.filter { $0.mainInformation.category == category }
        case .favorites:
            return recipes.filter { $0.isFavorite }
        }
    }
    
    init(viewStyle: ViewStyle) {
        self.viewStyle = viewStyle
    }
    
    let viewStyle: ViewStyle
    
    func save(recipe: Recipe) {
        allRecipes.append(recipe)
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = allRecipes.firstIndex(where: { $0.id == recipe.id }) else {
            fatalError("recipe id not found")
        }
        return $allRecipes[index]
    }
        
    var navigationTitle: String {
        switch viewStyle {
        case .category: return "Recipes"
        case .favorites: return "Favorite Recipes"
        }
    }
    enum ViewStyle {
        case category(MainInformation.Category)
        case favorites
    }
}
