//
//  VariableAlertView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 14/11/2024.
//

import SwiftUI

struct VariableAlertView: View {
    private let item: any VariableAlertItem

    public init(_ item: any VariableAlertItem) {
        self.item = item
    }

    public var body: some View {
        VStack(spacing: .spacing.large) {
            VStack(spacing: .spacing.medium) {
                item.image
                    .resizable()
                    .frame(width: 40, height: 40)

                H3Text(item.title)
            }

            if let message = item.message {
                P2Text(message)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            HStack(spacing: .spacing.small) {
                if let secondaryButton = item.secondaryButton {
                    Button {
                        secondaryButton.action()
                    } label: {
                        secondaryButton.title
                    }
                    .buttonStyle(.secondary())
                }

                Button {
                    item.primaryButton.action()
                } label: {
                    item.primaryButton.title
                }
                .buttonStyle(.primary())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(DesignSystem.Foundation.Measurements.Padding)
        .padding(.bottom, DesignSystem.Foundation.Measurements.Padding.bottom)
        .background(DesignSystem.Tokens.Colors.background)
    }
}
