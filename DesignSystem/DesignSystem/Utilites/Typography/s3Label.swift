//
//  s3Label.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension AttributedString {
    public static func s3Label(text: String, color: Color) -> AttributedString {
        switch LanguageSettings.shared.language {
            case .english:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        smallTreeLabelDarkEnglish(text: text, color: color)
                    default:
                        smallThreeLabelLightEnglish(text: text, color: color)
                }
            case .arabic:
                switch UITraitCollection.current.userInterfaceStyle {
                    case .dark:
                        smallThreeLabelDarkArabic(text: text, color: color)
                    default:
                        smallThreeLabelLightArabic(text: text, color: color)
                }
        }
    }
    
    private static func smallTreeLabelDarkEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.regular.swiftUIFont(fixedSize: .fontSizes.s3),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func smallThreeLabelLightEnglish(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.regular.swiftUIFont(fixedSize: .fontSizes.s3),
            foregroundColor: color,
            letterSpacing: 0.7
        )
    }
    
    private static func smallThreeLabelDarkArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Inter.regular.swiftUIFont(fixedSize: .fontSizes.s3),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
    
    private static func smallThreeLabelLightArabic(text: String, color: Color) -> AttributedString {
        createAttributedString(
            text: text,
            font: FontFamily.Cairo.regular.swiftUIFont(fixedSize: .fontSizes.s3),
            foregroundColor: color,
            letterSpacing: 0.0
        )
    }
}
