//
//  RecipeMainInfoView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeMainInfoView: View {
    @State var name = ""
    @State var description = "This is a great recipe!"

    var body: some View {
        VStack {
            HStack {
                Text("Name:")
                    .padding()
                TextField("Apple Pie", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            VStack {
                HStack {
                    Text("Description:")
                        .padding()
                    Spacer()
                }
                TextEditor(text: $description)
                    .border(Color.black)
                    .padding([.leading, .trailing])
            }
            Spacer()
        }
    }
}

struct RecipeMainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeMainInfoView()
    }
}
