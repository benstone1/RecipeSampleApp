//
//  AddNewDirectionView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/18/21.
//

import SwiftUI

struct AddNewDirectionView: AddNewElementView {
    
    // MARK: - AddElementsView Conformance
    
    typealias Element = Direction
    
    
    let viewStyle: ViewStyle<Direction>
    @Binding var direction: Direction
    
    init(element: Binding<Direction>, viewStyle: ViewStyle<Direction> = .edit) {
        self.viewStyle = viewStyle
        self._direction = element
    }
    
    // MARK: - Environment and State
    
    @Environment(\.presentationMode) private var mode
    @AppStorage("color") var color: Color = .green

    @State private var isRequired = true

    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            Form {
                TextEditorWithPlaceholder(text: $direction.description)
                    .padding(20)
                Toggle("Required", isOn: $direction.isRequired)
                SaveButton(element: $direction, viewStyle: viewStyle)
            }
        }
    }
}

struct SaveButton<Element>: View {
    @Environment(\.presentationMode) private var mode
    @Binding var element: Element
    let viewStyle: ViewStyle<Element>
    
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

struct AddNewDirectionView_Previews: PreviewProvider {
    @State static var recipe = Recipe.allRecipes[0]
    
    static var previews: some View {
        AddNewDirectionView(element: $recipe.directions[0], viewStyle: .create({ _ in }))
        AddNewDirectionView(element: $recipe.directions[0], viewStyle: .edit)
    }
}
