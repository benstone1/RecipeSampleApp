//
//  SettingsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/19/21.
//

import SwiftUI


extension Color: RawRepresentable {
    public init?(rawValue str: String) {
        do {
            let encodedData = str.data(using: .utf8)!
            let components = try JSONDecoder().decode([Double].self, from: encodedData)
            self = Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
        }
        catch {
            return nil
        }
    }

    public var rawValue: String {
        guard let cgFloatComponents = UIColor(self).cgColor.components else { return "" }
        let doubleComponents = cgFloatComponents.map { Double($0) }
        do {
            let encodedComponents = try JSONEncoder().encode(doubleComponents)
            return String(data: encodedComponents, encoding: .utf8) ?? ""
        }
        catch {
            return ""
        }
    }
}

struct SettingsView: View {
    @AppStorage("color") var color: Color = .white
    @AppStorage("hideOptionalSteps") var hideOptionalSteps: Bool = false
    
    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            VStack {
                Text("Settings")
                    .font(.title)
                    .padding()
                Form {
                    Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                    ColorPicker("Color", selection: $color)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
