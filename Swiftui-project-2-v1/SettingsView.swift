//
//  SettingsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/19/21.
//

import SwiftUI

extension Color: RawRepresentable {
    public init?(rawValue str: String) {
        let components = str.dropFirst().dropLast().components(separatedBy: ",").map { Double($0.trimmingCharacters(in: .whitespaces))! }
        self = Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
    }

    public var rawValue: String {
        return UIColor(self).cgColor.components!.description
    }
}

struct SettingsView: View {
    @AppStorage("color") var color: Color = Color.white
    
    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            ColorPicker("Color", selection: $color)
                .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
