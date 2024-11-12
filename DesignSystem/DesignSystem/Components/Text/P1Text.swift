//
//  P1Text.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public struct P1Text: TextProtocol {
    public let text: Text

    public init(_ text: Text) {
        self.text = text
    }

    public var body: some View {
        text
            .font(DesignSystem.Foundation.Typography.medium.swiftUIFont(size: .fontSizes.p1.size))
            .tracking(DesignSystem.Foundation.Measurements.Font.letterSpacing)
            .lineSpacing(.fontSizes.p1.lineSpacing)
    }
}
