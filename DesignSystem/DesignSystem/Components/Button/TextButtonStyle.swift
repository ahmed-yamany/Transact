//
//  TextButtonStyle.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import SwiftUI

public struct TextButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(configuration))
            .font(DesignSystem.Foundation.Typography.regular.swiftUIFont(size: .fontSizes.p3.size))
    }


    private func foregroundColor(_ configuration: Configuration) -> Color {
        if configuration.isPressed || !isEnabled {
            return DesignSystem.Tokens.Colors.inactive
        }
        return DesignSystem.Tokens.Colors.primary
    }
}

public extension ButtonStyle where Self == TextButtonStyle {
    static func text() -> Self {
        TextButtonStyle()
    }
}
