//
//  AddDirectionsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/18/21.
//

import SwiftUI

struct AddDirectionsView: View {
    @Binding var directions: [Direction]
    var body: some View {
        VStack {
            let addDirectionView = AddNewDirectionView { direction in
                directions.append(direction)
            }
            if directions.isEmpty {
                Spacer()
                NavigationLink("Add the first step", destination: addDirectionView)
                Spacer()
            } else {
                List {
                    ForEach(directions) { direction in
                        Text(direction.description)
                    }
                    .onDelete { directions.remove(atOffsets: $0) }
                    .onMove { indices, newOffet in directions.move(fromOffsets: indices, toOffset: newOffet) }
                    NavigationLink("Add another step",
                                   destination: addDirectionView)
                        .foregroundColor(.blue)
                }
                .toolbar {
                    EditButton()
                }
            }
        }
    }
}

struct AddDirectionsView_Previews: PreviewProvider {
    @State static var directions = [Direction](Recipe.allRecipes[0].directions)
    @State static var emptyDirections = [Direction]()
    
    static var previews: some View {
        AddDirectionsView(directions: $directions)
        AddDirectionsView(directions: $emptyDirections)
    }
}
