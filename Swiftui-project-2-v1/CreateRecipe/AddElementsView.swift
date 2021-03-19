//
//  AddElementsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/18/21.
//

import SwiftUI

protocol AddNewElementView: View {
    associatedtype Element
    init(onCreate: @escaping (Element) -> Void)
    var onCreate: (Element) -> Void { get }
}

struct AddElementsView<Element: Identifiable & CustomStringConvertible, DestinationView: AddNewElementView>: View where Element == DestinationView.Element {
    @Binding var elements: [Element]
                
    var elementName: String { String(describing: Element.self).lowercased() }
    
    var body: some View {
        VStack {
            let addElementView = DestinationView { newElement in
                elements.append(newElement)
            }
            if elements.isEmpty {
                Spacer()
                NavigationLink("Add the first \(elementName)", destination: addElementView)
                Spacer()
            } else {
                HStack {
                    Spacer()
                    EditButton()
                        .padding()
                }
                List {
                    ForEach(elements) { element in
                        Text(element.description)
                    }
                    .onDelete { elements.remove(atOffsets: $0) }
                    .onMove { indices, newOffet in elements.move(fromOffsets: indices, toOffset: newOffet) }
                    NavigationLink("Add another \(elementName)",
                                   destination: addElementView)
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct AddElementsView_Previews: PreviewProvider {
    @State static var ingredients = [Ingredient]()
    
    static var previews: some View {
        AddElementsView<Ingredient, AddNewIngredientView>(elements: $ingredients)
    }
}
