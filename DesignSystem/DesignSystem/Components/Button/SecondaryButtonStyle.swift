//
//  SecondaryButtonStyle 2.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 14/11/2024.
//


import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    private let size: ButtonSize

    public init(size: ButtonSize) {
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(configuration))
            .font(DesignSystem.Foundation.Typography.regular.swiftUIFont(size: .fontSizes.p3.size))
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .background(backgroundColor(configuration: configuration))
            .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
    }

    @ViewBuilder
    private func backgroundColor(configuration: Configuration) -> some View {
        if configuration.isPressed {
            DesignSystem.Tokens.Colors.inactive
        } else if !isEnabled {
            DesignSystem.Tokens.Colors.inactive
        } else {
            DesignSystem.Tokens.Colors.secondaryButtonBackgroundColor
        }
    }

    private func foregroundColor(_ configuration: Configuration) -> Color {
        DesignSystem.Tokens.Colors.secondaryButtonForgroundColor
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static func secondary(_ size: ButtonSize = .big) -> Self {
        SecondaryButtonStyle(size: size)
    }
}
