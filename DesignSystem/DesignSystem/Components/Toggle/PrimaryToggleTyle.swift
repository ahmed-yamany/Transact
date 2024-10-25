//
//  PrimaryToggleTyle.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 25/10/2024.
//

import SwiftUI

public struct PrimaryToggleTyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: DesignSystem.Foundation.Measurements.Spacing.medium) {
            Button {
                configuration.isOn.toggle()
            } label: {
                Group {
                    if configuration.isOn {
                        DesignSystem.Foundation.Icons.checkmarkOn.swiftUIImage
                            .resizable()
                    } else {
                        Image(systemName: "square")
                            .resizable()
                            .foregroundStyle(DesignSystem.Tokens.Colors.primary)
                    }
                }
                .frame(width: 24, height: 24)
            }

            configuration.label
        }
    }
}

public extension ToggleStyle where Self == PrimaryToggleTyle {
    static var primary: Self { PrimaryToggleTyle() }
}
