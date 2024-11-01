//
//  PrimaryOTPTextField.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import SwiftUI
import SwiftUIViews

public struct PrimaryOTPTextField: View {
    @Binding var otp: String
    let otpLength: Int

    public init(otp: Binding<String>, otpLength: Int) {
        _otp = otp
        self.otpLength = otpLength
    }

    public var body: some View {
        OTPTextField(
            otp: $otp,
            otpLength: otpLength,
            spacing: DesignSystem.Foundation.Measurements.Spacing.medium) { pin, _, _ in
                Text(pin)
                    .frame(width: 52, height: 58)
                    .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)
                    .background(DesignSystem.Tokens.Colors.background)
                    .clipShape(roundedRectangle)
                    .background {
                        roundedRectangle
                            .stroke(lineWidth: DesignSystem.Foundation.Measurements.BorderWidth.default)
                            .fill(DesignSystem.Tokens.Colors.secondaryText)
                    }
            }
    }

    private var roundedRectangle: some Shape {
        RoundedRectangle(cornerRadius: DesignSystem.Foundation.Measurements.BorderRadius.default)
    }
}
