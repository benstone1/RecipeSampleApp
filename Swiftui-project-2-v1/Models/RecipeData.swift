//
//  RecipeData.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/29/21.
//

import SwiftUI

class RecipeData: ObservableObject {
    @Published var recipes = [Recipe]() {
        didSet {
            saveRecipes()  // TODO: How bad is this?  Seems to work...
        }
    }
    
    func loadRecipes() {
        guard let data = try? Data(contentsOf: recipesFileURL) else {
            #if DEBUG
                recipes = Recipe.allRecipes
            #endif
            return
        }
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
            recipes = savedRecipes
        }
        catch {
            fatalError("An error occurred while loading recipes: \(error)")
        }
    }
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        }
        catch {
            fatalError("An error occurred while saving recipes: \(error)")
        }
    }
    
    private var recipesFileURL: URL {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                 in: .userDomainMask,
                                                                 appropriateFor: nil,
                                                                 create: false)
            return documentsDirectory.appendingPathComponent("recipeData")
        }
        catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
}
