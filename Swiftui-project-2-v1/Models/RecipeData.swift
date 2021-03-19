//
//  RecipeData.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/19/21.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = [Recipe]()
    
    private let filename = "recipes.plist"
    
    private var internalRecipesURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(filename)
    }
    
    func update(_ recipe: Recipe) {
        
    }
        
    func save() {
        do {
            let encodedRecipes = try PropertyListEncoder().encode(recipes)
            try encodedRecipes.write(to: internalRecipesURL)
        }
        catch {
            print("Error saving recipes")
        }
    }
    
    func load() {
        guard let data = FileManager.default.contents(atPath: internalRecipesURL.path) else { return }
        do {
            let savedRecipes = try PropertyListDecoder().decode([Recipe].self, from: data)
            self.recipes = savedRecipes
        }
        catch {
            print("Error loading recipes")
        }
    }
}
