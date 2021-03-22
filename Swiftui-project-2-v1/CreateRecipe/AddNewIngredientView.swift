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
        
    let viewStyle: ViewStyle<Ingredient>
    
    private let formatter: NumberFormatter
    
    init(element: Binding<Ingredient>, viewStyle: ViewStyle<Ingredient> = .edit) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        self.formatter = formatter
        self.viewStyle = viewStyle
        self._ingredient = element
    }
    
    // MARK: - Environment and State
    
    @Environment(\.presentationMode) var mode
    @Binding private var ingredient: Ingredient
    
    var body: some View {
        Form {
            TextField("Apple", text: $ingredient.name)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                HStack {
                    Text("Quantity:")
                    TextField("Quantity", value: $ingredient.quantity, formatter: formatter)
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

struct AddNewIngredientView_Previews: PreviewProvider {
    @State static var ingredient = Ingredient()
    
    static var previews: some View {
        AddNewIngredientView(element: $ingredient, viewStyle: .edit)
    }
}
