//
//  P4Text.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public struct P4Text: View {
    
    private let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(DesignSystem.Foundation.Typography.regular.swiftUIFont(size: .fontSizes.p4.size))
            .tracking(DesignSystem.Foundation.Measurements.Font.letterSpacing)
            .lineSpacing(.fontSizes.p4.lineSpacing)
    }
}
