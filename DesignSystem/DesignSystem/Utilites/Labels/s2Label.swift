//
//  s2Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func s2Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        smallTwoLabelDarkEnglish(text: text, color: color)
                    default:
                        smallTwoLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        smallTwoLabelDarkArabic(text: text, color: color)
                    default:
                        smallTwoLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func smallTwoLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.regular.swiftUIFont(fixedSize: 10),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func smallTwoLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.regular.swiftUIFont(fixedSize: 10),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func smallTwoLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.regular.swiftUIFont(fixedSize: 10),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func smallTwoLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.regular.swiftUIFont(fixedSize: 10),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
