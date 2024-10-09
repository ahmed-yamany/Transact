//
//  SecondaryButtonConfigurations.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI

struct SecondaryButtonBackgroundConfigurations: ButtonBackgroundConfigurations {
    var background: LinearGradient = LinearGradient(colors: [], startPoint: .top, endPoint: .top)
    var isPressedBackground: Color = ColorTokens.offBackground
    var disabledBackground: Color = .clear
}

struct SecondaryButtonForegroundConfigurations: ButtonForegroundConfigurations {
    var foregroundColor: Color = ColorTokens.actionAndInfo
    var isPressedForegroundColor: Color = ColorTokens.actionAndInfo
    var disabledForegroundColor: Color = ColorTokens.actionAndInfo
}

struct SecondaryButtonBorderConfigurations: ButtonBorderConfigurations {
    var color: Color = ColorTokens.actionAndInfo
    var lineWidth: CGFloat = 1
    var cornerRadius: CGFloat = 4
}

public struct SecondaryButtonConfigurations: ButtonStyleConfigurations {
    
    public var font: Font {
        switch LanguageSettings.shared.language {
            case .arabic:
                FontFamily.Cairo.regular.swiftUIFont(fixedSize: 14)
            case .english:
                FontFamily.Inter.regular.swiftUIFont(fixedSize: 14)
        }
    }
    
    public let foreground: ButtonForegroundConfigurations = SecondaryButtonForegroundConfigurations()
    public let background: ButtonBackgroundConfigurations? = SecondaryButtonBackgroundConfigurations()
    public let border: (any ButtonBorderConfigurations)? = SecondaryButtonBorderConfigurations()
    
    public var size: (any ButtonSize)?
    
    init(size: (any ButtonSize)? = nil) {
        self.size = size
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle<SecondaryButtonConfigurations> {
    static func secondaryBig() -> Self {
        let configurations = SecondaryButtonConfigurations(size: .big)
        return PrimaryButtonStyle(styleConfiguration: configurations)
    }
    
    static func secondarySmall() -> Self {
        let configurations = SecondaryButtonConfigurations(size: .small)
        return PrimaryButtonStyle(styleConfiguration: configurations)
    }
}


