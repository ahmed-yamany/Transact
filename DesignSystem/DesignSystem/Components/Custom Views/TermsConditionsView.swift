//
//  TermsConditionsView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 20/10/2024.
//

import Localization
import SwiftUI

public struct TermsConditionsView: View {
    public init() {}

    public var body: some View {
        P4Text(string)
    }

    private var string: AttributedString {
        var string = AttributedString("\(L10n.termsConditionDescription) \(L10n.termsOfUse) \(L10n.and) \(L10n.privacyPolicy)")

        if let range = string.range(of: L10n.termsOfUse) {
            string[range].foregroundColor = DesignSystem.Tokens.Colors.primary
        }

        if let range = string.range(of: L10n.privacyPolicy) {
            string[range].foregroundColor = DesignSystem.Tokens.Colors.primary
        }

        return string
    }
}
