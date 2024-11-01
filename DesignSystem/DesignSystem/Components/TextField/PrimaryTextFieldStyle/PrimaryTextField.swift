//
//  PrimaryTextField.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 20/10/2024.
//

import SwiftUI

public struct PrimaryTextField: View {
    let placeholder: String
    let title: String
    @Binding var text: String
    let error: (any PrimaryTextFieldError)?
    let secured: Bool
    let tip: String?

    public init(
        _ placeholder: String,
        title: String,
        text: Binding<String>,
        error: (any PrimaryTextFieldError)? = nil,
        secured: Bool = false,
        tip: String? = nil
    ) {
        self.placeholder = placeholder
        self.title = title
        _text = text
        self.error = error
        self.secured = secured
        self.tip = tip
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .spacing.medium) {
            P3Text(title)

            VStack(spacing: .spacing.xSmall) {
                Group {
                    Group {
                        if secured {
                            SecureField(placeholder, text: $text)
                        } else {
                            TextField(placeholder, text: $text)
                        }
                    }
                    .overlay(alignment: .trailing) {
                        if !text.isEmpty {
                            xButton
                        }
                    }
                }
                .font(DesignSystem.Foundation.Typography.regular.swiftUIFont(size: .fontSizes.p2.size))
                .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)
                .frame(height: 46)
                .padding(.horizontal, .spacing.medium)
                .background(DesignSystem.Tokens.Colors.offBackground)

                if let tip {
                    P4Text(tip)
                        .foregroundStyle(DesignSystem.Tokens.Colors.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let error {
                    P4Text(error.text)
                        .foregroundStyle(error.color)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    private var xButton: some View {
        Button {
            text.removeAll()
        } label: {
            DesignSystem.Foundation.Icons.xCircleFill.swiftUIImage
                .renderingMode(.template)
                .resizable()
                .frame(width: 17, height: 17)
        }
        .foregroundStyle(DesignSystem.Tokens.Colors.secondaryText)
    }
}
