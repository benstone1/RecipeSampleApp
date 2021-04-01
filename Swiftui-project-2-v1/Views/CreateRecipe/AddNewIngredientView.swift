//
//  AddNewIngredientView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/17/21.
//

import SwiftUI

struct AddNewIngredientView: AddNewElementView {
    
    // MARK: - AddElementsView Conformance
    
    typealias Element = Ingredient
        
    let viewStyle: ModifyElementViewStyle<Ingredient>
    @Binding var ingredient: Ingredient
    @AppStorage("color") var color: Color = .white
        
    init(element: Binding<Ingredient>, viewStyle: ModifyElementViewStyle<Ingredient> = .edit) {
        self.viewStyle = viewStyle
        self._ingredient = element
    }
    
    // MARK: - Environment and State
        
    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            Form {
                TextField("Apple", text: $ingredient.name)
                Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                            .keyboardType(.numbersAndPunctuation)
                    }
                }
                Picker("Unit", selection: $ingredient.unit) {
                    ForEach(Ingredient.Unit.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                SaveButton(element: $ingredient, viewStyle: viewStyle)
            }
            .navigationBarTitle("Add Ingredient")
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct AddNewIngredientView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    
    static var previews: some View {
        AddNewIngredientView(element: $recipe.ingredients[0], viewStyle: .edit)
    }
}
