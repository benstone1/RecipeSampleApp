//
//  AddNewDirectionView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/18/21.
//

import SwiftUI

struct AddNewDirectionView: View {
    @Environment(\.presentationMode) var mode
    let onCreate: (Direction) -> Void
    @State var step = ""
    init(onCreate: @escaping (Direction) -> Void) {
        self.onCreate = onCreate
    }

    var body: some View {
        VStack {
            TextField("Set the oven to 300℉", text: $step)
                .padding()
            Button("Add Step") {
                onCreate(Direction(step))
                mode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddNewDirectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDirectionView { _ in return }
    }
}
