//
//  h3Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func h3Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        headingThreeLabelDarkEnglish(text: text, color: color)
                    default:
                        headingThreeLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        headingThreeLabelDarkArabic(text: text, color: color)
                    default:
                        headingThreeLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func headingThreeLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.semiBold.swiftUIFont(fixedSize: 20),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func headingThreeLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.semiBold.swiftUIFont(fixedSize: 20),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func headingThreeLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.semiBold.swiftUIFont(fixedSize: 20),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func headingThreeLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.semiBold.swiftUIFont(fixedSize: 20),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
