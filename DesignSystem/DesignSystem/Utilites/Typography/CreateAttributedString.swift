//
//  createAttributedString.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 22/09/2024.
//

import SwiftUI


extension AttributedString {
    public static func createAttributedString(
        text: String,
        font: Font,
        foregroundColor: Color,
        letterSpacing: CGFloat
    ) -> AttributedString {
        var string = AttributedString(text)
        
        string.foregroundColor = foregroundColor
        string.font = font
        string.tracking = letterSpacing
        
        return string
    }
}
