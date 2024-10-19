//
//  H3Text.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public struct H3Text: View {
    
    private let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(DesignSystem.Foundation.Typography.semiBold.swiftUIFont(size: .fontSizes.h3.size))
            .tracking(DesignSystem.Foundation.Measurements.Font.letterSpacing)
            .lineSpacing(.fontSizes.h3.lineSpacing)
    }
}
