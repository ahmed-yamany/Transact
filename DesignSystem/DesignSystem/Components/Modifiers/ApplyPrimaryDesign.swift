//
//  ApplyPrimaryDesign.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func applyPrimaryDesign() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
            .tint(DesignSystem.Tokens.Colors.tint)
            .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)
            .background(DesignSystem.Tokens.Colors.background)
    }
}
