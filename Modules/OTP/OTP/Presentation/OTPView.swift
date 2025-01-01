//
//  OTPView.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import DesignSystem
import Localization
import SwiftUI

public struct OTPView<ViewModel: OTPViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel
    private let content: OTPContentInterFace

    public init(viewModel: ViewModel, content: OTPContentInterFace) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: .measurements.Spacing.xxxLarge) {
                AuthenticationView(
                    title: L10n.Otp.title,
                    subtitle: L10n.Otp.subtitle(
                        viewModel.phonenumber,
                        viewModel.otpCodeExpiresIn
                    )
                )

                PrimaryOTPTextField(otp: $viewModel.otp, otpLength: viewModel.otpLength)

                resendButton

                VStack(spacing: .measurements.Spacing.xxxLarge) {
                    verifyButton

                    TermsConditionsView()
                }
                .padding(.bottom, .measurements.Spacing.xxxLarge)
            }
            .frame(maxWidth: .infinity)
            .padding(CGFloat.measurements.Padding)
        }
        .applyPrimaryDesign()
    }

    private var resendButton: some View {
        Button {
            viewModel.resendButtonTapped()
        } label: {
            HStack {
                P2Text(L10n.Localizable.resendCode)

                DesignSystem.Foundation.Icons.reload.swiftUIImage
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .buttonStyle(.text())
        .disabled(viewModel.disableResendButton)
    }

    private var verifyButton: some View {
        Button(L10n.Localizable.verify) {
            viewModel.verifyButtonTapped()
        }
        .buttonStyle(.primary())
        .disabled(viewModel.disableVerifyButton)
    }
}
