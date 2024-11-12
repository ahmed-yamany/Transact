//
//  H3Text.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public struct H3Text: TextProtocol {
    public let text: Text

    public init(_ text: Text) {
        self.text = text
    }

    public var body: some View {
        text
            .font(DesignSystem.Foundation.Typography.semiBold.swiftUIFont(size: .fontSizes.h3.size))
            .tracking(DesignSystem.Foundation.Measurements.Font.letterSpacing)
            .lineSpacing(.fontSizes.h3.lineSpacing)
    }
}
