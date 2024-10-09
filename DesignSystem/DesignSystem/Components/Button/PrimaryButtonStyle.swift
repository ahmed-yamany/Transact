//
//  PrimaryButtonStyle.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    private let size: ButtonSize
    
    public init(size: ButtonSize) {
        self.size = size
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(configuration))
            .font(DesignSystem.Foundation.Typography.regular.swiftUIFont(size: .fontSizes.p3))
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .background(backgroundColor(configuration: configuration))
            .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
    }
    
    @ViewBuilder
    func backgroundColor(configuration: Configuration) -> some View {
        if configuration.isPressed {
            DesignSystem.Tokens.Colors.inactive
        } else if !isEnabled {
            DesignSystem.Tokens.Colors.inactive
        } else {
            DesignSystem.Tokens.Colors.gradient
        }
    }

    func foregroundColor(_ configuration: Configuration) -> Color {
        DesignSystem.Tokens.Colors.mobileBG
    }
}

