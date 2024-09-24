//
//  PrimaryButtonStyle.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI
import SwiftUIModifiers

public struct PrimaryButtonStyle<StyleConfiguration: ButtonStyleConfigurations>: ButtonStyle {
    let styleConfiguration: StyleConfiguration
    @Environment(\.isEnabled) private var isEnabled
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(configuration))
            .font(styleConfiguration.font)
            .onCondition(styleConfiguration.size != nil) {
                if let size = styleConfiguration.size  {
                    $0.frame(maxWidth: .infinity)
                        .frame(height: size.height)
                        .background(backgroundColor(configuration))
                        .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius))
                } else { $0 }
            }
            .onCondition(styleConfiguration.border != nil) {
                if let border = styleConfiguration.border {
                    $0.border(border.color, lineWidth: border.lineWidth, radius: border.cornerRadius)
                } else { $0 }
            }
    }
    
    @ViewBuilder
    func backgroundColor(_ configuration: Configuration) -> some View {
        if configuration.isPressed {
            styleConfiguration.background.isPressedBackground
        } else if !isEnabled {
            styleConfiguration.background.disabledBackground
        } else {
            styleConfiguration.background.background
        }
    }

    func foregroundColor(_ configuration: Configuration) -> Color {
        if configuration.isPressed {
            styleConfiguration.foreground.isPressedForegroundColor
        } else if !isEnabled {
            styleConfiguration.foreground.disabledForegroundColor
        } else {
            styleConfiguration.foreground.foregroundColor
        }
    }
}

