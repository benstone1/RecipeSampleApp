//
//  RecipeCategoryGrid.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/24/21.
//

import SwiftUI

struct RecipeCategoryGrid: View {
    @AppStorage("recipes") var recipes: [Recipe] = Recipe.allRecipes
    var body: some View {
        let columns = [
            GridItem(),
            GridItem(),
        ]
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(MainInformation.Category.allCases) { category in
                        NavigationLink(
                            destination: RecipesList(recipes: $recipes, category: category),
                            label: {
                                CategoryView(category: category)
                            })
                            .padding()
                    }
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.5)
            Text(category.rawValue.capitalized)
                .font(.title2)
                .foregroundColor(Color.black)
        }
    }
}

struct RecipeCategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGrid()
    }
}
