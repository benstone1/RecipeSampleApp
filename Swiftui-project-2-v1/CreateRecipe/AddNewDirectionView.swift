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
    let direction: Binding<Direction>
    
    init(element: Binding<Direction>, viewStyle: ViewStyle<Direction> = .edit) {
        self.viewStyle = viewStyle
        self.direction = element
    }
    
    // MARK: - Environment and State
    
    @Environment(\.presentationMode) private var mode
    
    @State private var step = "Set the oven to 300℉"
    @State private var isRequired = true
    @State private var userDidTapOnText = false

    var body: some View {
        Form {
            TextEditor(text: $step)
                .padding(20)
                .foregroundColor(userDidTapOnText ? .black : .gray)
                .onTapGesture { userDidTapOnText = true }
            Toggle("Required", isOn: $isRequired)
            SaveButton(element: direction, viewStyle: viewStyle)
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
                Button("Add Step") {
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
    @State static var direction = Direction("Bake")
    static var previews: some View {
        AddNewDirectionView(element: $direction, viewStyle: .edit)
    }
}
