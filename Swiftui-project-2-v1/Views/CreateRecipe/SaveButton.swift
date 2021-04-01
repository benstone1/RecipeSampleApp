//
//  SaveButton.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 4/1/21.
//

import SwiftUI

struct SaveButton<Element>: View {
    @Environment(\.presentationMode) private var mode
    
    @Binding var element: Element
    let viewStyle: ModifyElementViewStyle<Element>
    
    var body: some View {
        switch viewStyle {
        case let .create(onCreate):
            HStack {
                Spacer()
                Button("Save") {
                    onCreate(element)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
        case .edit: EmptyView()
        }
    }
}

struct SaveButton_Previews: PreviewProvider {
    @State static var ingredient = Ingredient(name: "Test", quantity: 2.0, unit: .cups)
    
    static var previews: some View {
        SaveButton(element: $ingredient, viewStyle: .edit)
        SaveButton(element: $ingredient, viewStyle: .create { _ in })
    }
}
