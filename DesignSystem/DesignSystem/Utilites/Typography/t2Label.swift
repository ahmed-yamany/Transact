//
//  t2Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func t2Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        titleTwoLabelDarkEnglish(text: text, color: color)
                    default:
                        titleTwoLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        titleTwoLabelDarkArabic(text: text, color: color)
                    default:
                        titleTwoLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func titleTwoLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.medium.swiftUIFont(fixedSize: 14),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func titleTwoLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.medium.swiftUIFont(fixedSize: 14),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func titleTwoLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.medium.swiftUIFont(fixedSize: 14),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func titleTwoLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.medium.swiftUIFont(fixedSize: 14),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
