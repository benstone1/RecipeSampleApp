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
    
    let onCreate: (Direction) -> Void
    let viewStyle: ViewStyle<Direction>

    init(viewStyle: ViewStyle<Direction> = .create, onCreate: @escaping (Direction) -> Void) {
        self.onCreate = onCreate
        self.viewStyle = viewStyle
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
            HStack {
                Spacer()
                Button("Add Step") {
                    onCreate(Direction(step))
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
    }
}

struct AddNewDirectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDirectionView { _ in return }
    }
}
