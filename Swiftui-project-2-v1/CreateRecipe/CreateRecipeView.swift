//
//  CreateRecipeView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct CreateRecipeView: View {
    @Environment(\.presentationMode) var mode

    @State var selection = Selection.main
    @State var name = ""
    @State var description = ""
    @State var ingredients = [Ingredient]()
    @State var directions = [Direction]()
    let viewModel = ViewModel()
    
    var onSave: (Recipe) -> Void
    
    init(onSave: @escaping (Recipe) -> Void) {
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Picker"), content: {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            })
            .pickerStyle(SegmentedPickerStyle.init())
            switch selection {
            case .main:
                RecipeMainInfoView(name: $name, description: $description)
            case .ingredients:
                AddElementsView<Ingredient, AddNewIngredientView>(elements: $ingredients)
            case .directions:
                AddElementsView<Direction, AddNewDirectionView>(elements: $directions)                
            }
            Spacer()
            Button("Save Recipe") {
                let recipe = Recipe(name: name,
                                    ingredients: ingredients,
                                    description: description,
                                    directions: directions)
                onSave(recipe)
                mode.wrappedValue.dismiss()
            }
            .padding()
        }
        .navigationTitle("Create a New Recipe")
    }
    
    enum Selection {
        case main
        case ingredients
        case directions
    }
}

extension CreateRecipeView {
    struct ViewModel {
        func save(_ recipe: Recipe) {
            
        }
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView { _ in return }
    }
}
