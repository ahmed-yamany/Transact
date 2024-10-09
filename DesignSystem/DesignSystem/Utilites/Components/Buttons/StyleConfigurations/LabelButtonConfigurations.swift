//
//  LabelButtonConfigurations.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 25/09/2024.
//

import SwiftUI


struct LabelButtonForegroundConfigurations: ButtonForegroundConfigurations {
    var foregroundColor: Color = ColorTokens.actionAndInfo
    var isPressedForegroundColor: Color = ColorTokens.inactive
    var disabledForegroundColor: Color = ColorTokens.inactive
}


public struct LabelButtonConfigurations: ButtonStyleConfigurations {
    
    public var font: Font {
        switch LanguageSettings.shared.language {
            case .arabic:
                FontFamily.Cairo.regular.swiftUIFont(fixedSize: 16)
            case .english:
                FontFamily.Inter.regular.swiftUIFont(fixedSize: 16)
        }
    }
    
    public let foreground: ButtonForegroundConfigurations = LabelButtonForegroundConfigurations()
    public let background: ButtonBackgroundConfigurations? = nil
    public let border: (any ButtonBorderConfigurations)? = nil
    public let size: (any ButtonSize)? = nil
    
}

public extension ButtonStyle where Self == PrimaryButtonStyle<LabelButtonConfigurations> {
    static func labelButton() -> Self {
        let configurations = LabelButtonConfigurations()
        return PrimaryButtonStyle(styleConfiguration: configurations)
    }
}
