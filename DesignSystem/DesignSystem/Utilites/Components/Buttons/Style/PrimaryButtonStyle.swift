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
                if let size = styleConfiguration.size, let backgroundConfiguration = styleConfiguration.background  {
                    $0.frame(maxWidth: .infinity)
                        .frame(height: size.height)
                        .background(backgroundColor(backgroundConfiguration, configuration: configuration))
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
    func backgroundColor(_ backgroundConfiguration: ButtonBackgroundConfigurations, configuration: Configuration) -> some View {
        if configuration.isPressed {
            backgroundConfiguration.isPressedBackground
        } else if !isEnabled {
            backgroundConfiguration.disabledBackground
        } else {
            backgroundConfiguration.background
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

