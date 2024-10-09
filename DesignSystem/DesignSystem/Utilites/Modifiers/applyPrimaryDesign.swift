//
//  applyPrimaryDesign.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 25/09/2024.
//

import SwiftUI
import SwiftUIModifiers

public extension View {
    @ViewBuilder
    func applyPrimaryDesign() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                ColorTokens.background.ignoresSafeArea()
            }
            .closeKeyboardOnTap()
    }
}
