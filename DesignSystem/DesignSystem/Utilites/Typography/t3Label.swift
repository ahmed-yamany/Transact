//
//  t3Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func t3Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        titleThreeLabelDarkEnglish(text: text, color: color)
                    default:
                        titleThreeLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        titleThreeLabelDarkArabic(text: text, color: color)
                    default:
                        titleThreeLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func titleThreeLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.medium.swiftUIFont(fixedSize: .fontSizes.t3),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func titleThreeLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.medium.swiftUIFont(fixedSize: .fontSizes.t3),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func titleThreeLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.medium.swiftUIFont(fixedSize: .fontSizes.t3),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func titleThreeLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.medium.swiftUIFont(fixedSize: .fontSizes.t3),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
