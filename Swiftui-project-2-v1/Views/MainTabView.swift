//
//  MainTabView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject private var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            RecipeCategoryGrid()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
            NavigationView {
                RecipesList(viewStyle: .favorite)
            }
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .environmentObject(recipeData)
        .onAppear {
            recipeData.loadRecipes()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
