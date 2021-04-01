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
    
    
    let viewStyle: ModifyElementViewStyle<Direction>
    @Binding var direction: Direction
    
    init(element: Binding<Direction>, viewStyle: ModifyElementViewStyle<Direction> = .edit) {
        self.viewStyle = viewStyle
        self._direction = element
    }
    
    // MARK: - Environment and State
    
    @Environment(\.presentationMode) private var mode
    @AppStorage("color") var color: Color = .white

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

struct AddNewDirectionView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    
    static var previews: some View {
        AddNewDirectionView(element: $recipe.directions[0], viewStyle: .create({ _ in }))
        AddNewDirectionView(element: $recipe.directions[0], viewStyle: .edit)
    }
}
