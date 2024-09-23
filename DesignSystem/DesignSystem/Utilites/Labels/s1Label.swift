//
//  s1Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func s1Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        smallOneLabelDarkEnglish(text: text, color: color)
                    default:
                        smallOneLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        smallOneLabelDarkArabic(text: text, color: color)
                    default:
                        smallOneLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func smallOneLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.regular.swiftUIFont(fixedSize: 12),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func smallOneLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.regular.swiftUIFont(fixedSize: 12),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func smallOneLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.regular.swiftUIFont(fixedSize: 12),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func smallOneLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.regular.swiftUIFont(fixedSize: 12),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
