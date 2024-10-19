//
//  ContentView.swift
//  Driver
//
//  Created by Ahmed Yamany on 18/10/2024.
//

import SwiftUI
import DesignSystem
import Localization

struct ContentView: View {
    var body: some View {
        VStack {
            H1Text(L10n.appName)
                .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)
        }
        .applyPrimaryDesign()
    }
}

#Preview {
    ContentView()
}
