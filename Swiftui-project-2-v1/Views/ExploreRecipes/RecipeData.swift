//
//  RecipeData.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/26/21.
//

import SwiftUI

class RecipeData {
    @AppStorage("recipes") var allRecipes: [Recipe] = Recipe.allRecipes
    
    
}
