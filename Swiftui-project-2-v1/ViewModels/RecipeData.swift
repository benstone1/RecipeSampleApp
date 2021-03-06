//
//  RecipeData.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/29/21.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = [Recipe]() {
        didSet {
            throttleSave()
        }
    }
    
    func recipes(for category: MainInformation.Category, onlyFavorites: Bool) -> [Recipe] {
        recipes
            .filter { $0.mainInformation.category == category }
            .filter { onlyFavorites ? $0.isFavorite : true }
    }
    
    func index(for recipe: Recipe) -> Int {
        recipes.firstIndex { recipe.id == $0.id }!
    }
    
    private var saveTask: DispatchWorkItem?

    private func throttleSave() {
        // https://stackoverflow.com/questions/42444310/live-search-throttle-in-swift-3
        saveTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.saveRecipes()
        }
        saveTask = task
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now() + 2, execute: task)
    }
    
    func loadRecipes() {
        guard let data = try? Data(contentsOf: recipesFileURL) else {
            #if DEBUG
                recipes = Recipe.testRecipes
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
