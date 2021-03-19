//
//  SettingsView.swift
//  Swiftui-project-2-v1
//
//  Created by Ben Stone on 3/19/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isRed") var isRed: Bool = false
    
    var body: some View {
        ZStack {
            isRed ? Color.red : Color.blue
            Toggle("Is Red", isOn: $isRed)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
