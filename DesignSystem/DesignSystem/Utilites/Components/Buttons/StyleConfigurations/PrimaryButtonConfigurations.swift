//
//  PrimaryButtonConfigurations.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI

struct PrimaryButtonBackgroundConfigurations: ButtonBackgroundConfigurations {
    var background: LinearGradient = PrimaryLinearGradient()
    var isPressedBackground: Color = ColorTokens.inactive
    var disabledBackground: Color = ColorTokens.inactive
}

struct PrimaryButtonForegroundConfigurations: ButtonForegroundConfigurations {
    var foregroundColor: Color = ColorTokens.mobileBG
    var isPressedForegroundColor: Color = ColorTokens.mobileBG
    var disabledForegroundColor: Color = ColorTokens.mobileBG
}

public struct PrimaryButtonConfigurations: ButtonStyleConfigurations {
    
    public var font: Font {
        switch LanguageSettings.shared.language {
            case .arabic:
                FontFamily.Cairo.regular.swiftUIFont(fixedSize: 14)
            case .english:
                FontFamily.Inter.regular.swiftUIFont(fixedSize: 14)
        }
    }
    
    public let foreground: ButtonForegroundConfigurations = PrimaryButtonForegroundConfigurations()
    public let background: ButtonBackgroundConfigurations = PrimaryButtonBackgroundConfigurations()
    public let border: (any ButtonBorderConfigurations)? = nil
    
    public var size: (any ButtonSize)?
    
    init(size: (any ButtonSize)? = nil) {
        self.size = size
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle<PrimaryButtonConfigurations> {
    static func primaryBig() -> Self {
        let configurations = PrimaryButtonConfigurations(size: .big)
        return PrimaryButtonStyle(styleConfiguration: configurations)
    }
    
    static func primarySmall() -> Self {
        let configurations = PrimaryButtonConfigurations(size: .small)
        return PrimaryButtonStyle(styleConfiguration: configurations)
    }
}


