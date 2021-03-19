//
//  RecipeMainInfoView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeMainInfoView: View {
    @Binding var name: String
    @Binding var description: String

    var body: some View {
        Form {
            HStack {
                Text("Name:")
                    .padding()
                TextField("Apple Pie", text: $name)
            }
            VStack {
                Text("Description")
                TextEditor(text: $description)
            }
            .padding()
        }
    }
}

struct RecipeMainInfoView_Previews: PreviewProvider {
    @State static var name: String = ""
    @State static var description: String = "Sample description"
    
    static var previews: some View {
        RecipeMainInfoView(name: $name, description: $description)
    }
}
