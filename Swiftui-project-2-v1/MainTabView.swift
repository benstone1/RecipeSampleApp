//
//  MainTabView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RecipesList()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
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
