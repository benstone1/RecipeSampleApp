//
//  AddNewIngredientView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/17/21.
//

import SwiftUI

struct AddNewIngredientView: View {
    @Environment(\.presentationMode) var mode
    @State var selectedUnit: Ingredient.Unit = .cups
    @State var ingredientName = ""
    @State var quantity: Double = 1.5
    let formatter: NumberFormatter
    let onCreate: (Ingredient) -> Void
    
    init(onCreate: @escaping (Ingredient) -> Void) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        self.formatter = formatter
        self.onCreate = onCreate
    }
    
    var body: some View {
            Form {
                TextField("Apple", text: $ingredientName)
                Stepper(value: $quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity", value: $quantity, formatter: formatter)
                            .keyboardType(.decimalPad)
                    }
                }
                Picker("Unit", selection: $selectedUnit) {
                    ForEach(Ingredient.Unit.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                HStack {
                    Spacer()
                    Button("Save new ingredient") {
                        let newIngredient = Ingredient(name: ingredientName,
                                                       quantity: quantity,
                                                       unit: selectedUnit)
                        onCreate(newIngredient)
                        mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }        .navigationBarTitle("Add Ingredient")

        }
    
}

struct AddNewIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewIngredientView { ingredient in
            print("Added \(ingredient)")
        }
    }
}
