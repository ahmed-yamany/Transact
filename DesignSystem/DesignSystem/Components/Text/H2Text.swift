//
//  H2Text.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public struct H2Text: View {
    private let attributedString: AttributedString

    public init(_ text: String) {
        attributedString = AttributedString(text)
    }

    public init(_ attributedString: AttributedString) {
        self.attributedString = attributedString
    }

    public var body: some View {
        Text(attributedString)
            .font(DesignSystem.Foundation.Typography.bold.swiftUIFont(size: .fontSizes.h2.size))
            .tracking(DesignSystem.Foundation.Measurements.Font.letterSpacing)
            .lineSpacing(.fontSizes.h2.lineSpacing)
    }
}
