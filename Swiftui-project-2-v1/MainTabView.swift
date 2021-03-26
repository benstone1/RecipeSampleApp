//
//  MainTabView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("recipes") var recipes: [Recipe] = Recipe.allRecipes

    var body: some View {
        TabView {
            RecipeCategoryGrid()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
            NavigationView {
                RecipesList(recipes: $recipes, viewStyle: .favorite)
            }.tabItem { Label("Favorites", systemImage: "heart.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
