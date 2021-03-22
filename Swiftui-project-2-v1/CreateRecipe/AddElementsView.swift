//
//  AddElementsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/18/21.
//

import SwiftUI


enum ViewStyle<Element> {
    case create((Element) -> Void)
    case edit
}

protocol AddNewElementView: View {
    associatedtype Element
    init(element: Binding<Element>, viewStyle: ViewStyle<Element>)
}

protocol EmptyInitializable {
    init()
}

struct AddElementsView<Element: Identifiable & CustomStringConvertible & EmptyInitializable, DestinationView: AddNewElementView>: View where Element == DestinationView.Element {
    @Binding var elements: [Element]
    @State var newElement = Element()
    
    private var elementName: String { String(describing: Element.self).lowercased() }
    
    var body: some View {
        VStack {
            let addElementView = DestinationView(element: $newElement, viewStyle: .create({ newElement in
                elements.append(newElement)
                self.newElement = Element()
                print("Created the element")
            }))
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
                    ForEach(elements.indices) { index in
                        let element = elements[index]
                        NavigationLink(element.description, destination: DestinationView(element: $elements[index], viewStyle: .edit))
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
