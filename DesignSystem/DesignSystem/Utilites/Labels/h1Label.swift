//
//  h1Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 22/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func h1Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        headingOneLabelDarkEnglish(text: text, color: color)
                    default:
                        headingOneLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        headingOneLabelDarkArabic(text: text, color: color)
                    default:
                        headingOneLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func headingOneLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.bold.swiftUIFont(fixedSize: 32),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func headingOneLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.bold.swiftUIFont(fixedSize: 32),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func headingOneLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.bold.swiftUIFont(fixedSize: 32),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func headingOneLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.bold.swiftUIFont(fixedSize: 32),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
