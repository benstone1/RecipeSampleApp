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
    let viewModel = ViewModel()
    
    var onSave: (Recipe) -> Void
    
    @State var name: String
    @State var description: String
    @State var ingredients: [Ingredient]
    @State var directions: [Direction]

    init(name: String = "",
         description: String = "",
         ingredients: [Ingredient] = [],
         directions: [Direction] = [],
         onSave: @escaping (Recipe) -> Void) {
        self._name = State(initialValue: name)
        self._description = State(initialValue: description)
        self._ingredients = State(initialValue: ingredients)
        self._directions = State(initialValue: directions)
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Picker"), content: {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                RecipeMainInfoView(name: $name, description: $description)
            case .ingredients:
                AddElementsView<Ingredient, AddNewIngredientView>(elements: $ingredients)
            case .directions:
                AddElementsView<Direction, AddNewDirectionView>(elements: $directions)
            }
            Spacer()
            Button("Save") {
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
