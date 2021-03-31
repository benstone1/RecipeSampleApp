//
//  RecipeMainInfoView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/15/21.
//

import SwiftUI

struct RecipeMainInfoView: View {
    @AppStorage("color") var color: Color = .green
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            Form {
                HStack {
                    Text("Name:")
                        .padding()
                    TextField("Apple Pie", text: $mainInformation.name)
                }
                TextEditorWithPlaceholder(text: $mainInformation.description)
                Picker("Category", selection: $mainInformation.category) {
                    ForEach(MainInformation.Category.allCases) { category in
                        Text(category.rawValue)
                    }
                }
                .padding()
            }
        }
    }
}

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    let placeholderText = "Description"
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholderText)
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
            }
            TextEditor(text: $text)
        }
    }
}

struct RecipeMainInfoView_Previews: PreviewProvider {
    @State static var mainInformation = MainInformation(name: "Test Name",
                                                        description: "Test Description",
                                                        category: .breakfast)
    @State static var emptyInformation = MainInformation(name: "", description: "", category: .breakfast)
        
    static var previews: some View {
        RecipeMainInfoView(mainInformation: $mainInformation)
        RecipeMainInfoView(mainInformation: $emptyInformation)
    }
}
