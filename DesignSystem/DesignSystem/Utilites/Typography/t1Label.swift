//
//  t1Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func t1Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        titleOneLabelDarkEnglish(text: text, color: color)
                    default:
                        titleOneLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        titleOneLabelDarkArabic(text: text, color: color)
                    default:
                        titleOneLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func titleOneLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.medium.swiftUIFont(fixedSize: .fontSizes.t1),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func titleOneLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.medium.swiftUIFont(fixedSize: .fontSizes.t1),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func titleOneLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.medium.swiftUIFont(fixedSize: .fontSizes.t1),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func titleOneLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.medium.swiftUIFont(fixedSize: .fontSizes.t1),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
