//
//  TextEditorWithPlaceholder.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 4/1/21.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    let placeholderText = "Description"
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholderText)
                    .foregroundColor(.gray)
                    .opacity(0.75)
                    .padding(.leading, 5)
            }
            TextEditor(text: $text)
        }
    }
}

struct TextEditorWithPlaceholder_Previews: PreviewProvider {
    @State static var emptyText = ""
    @State static var nonEmptyText = "test"
    
    static var previews: some View {
        TextEditorWithPlaceholder(text: $emptyText)
        TextEditorWithPlaceholder(text: $nonEmptyText)
    }
}

