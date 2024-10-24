//
//  AuthenticationView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import SwiftUI

public struct AuthenticationView: View {
    private let title: String
    private let subtitle: String

    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack(spacing: .spacing.xLarge) {
            BlueLogoView()

            VStack(spacing: .spacing.medium) {
                H4Text(title)

                P3Text(subtitle)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)
        }
    }
}
