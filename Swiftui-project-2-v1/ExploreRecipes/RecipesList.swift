//
//  ContentView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/8/21.
//

import SwiftUI

struct RecipesList: View {
    
    var recipes = Recipe.allRecipes
    
    var body: some View {
        NavigationView {
            VStack {
                List(recipes) { recipe in
                    NavigationLink(recipe.name,
                                   destination: RecipeDetailView(recipe: recipe))
                }
            }
            .navigationBarTitle("Recipes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesList()
    }
}
