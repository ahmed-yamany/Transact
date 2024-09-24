//
//  h2Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 22/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func h2Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        headingTwoLabelDarkEnglish(text: text, color: color)
                    default:
                        headingTwoLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        headingTwoLabelDarkArabic(text: text, color: color)
                    default:
                        headingTwoLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func headingTwoLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.bold.swiftUIFont(fixedSize: 24),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func headingTwoLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.bold.swiftUIFont(fixedSize: 24),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func headingTwoLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.bold.swiftUIFont(fixedSize: 24),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func headingTwoLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.bold.swiftUIFont(fixedSize: 24),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
