//
//  ForgotPasswordView.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import DesignSystem
import Localization
import SwiftUI

public struct ForgotPasswordView<ViewModel: ForgotPasswordViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: .measurements.Spacing.xxxLarge) {
                AuthenticationView(title: L10n.forgotPassword, subtitle: L10n.ForgotPassword.subtitle)

                phoneNumberTextField

                VStack(spacing: .measurements.Spacing.large) {
                    forgotPasswordButton

                    TermsConditionsView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(CGFloat.measurements.Padding)
        }
        .applyPrimaryDesign()
    }

    private var phoneNumberTextField: some View {
        PrimaryTextField(
            L10n.enterPhoneNumber,
            title: L10n.phoneNumber,
            text: $viewModel.phoneNumber,
            error: viewModel.phoneNumberError
        )
        .keyboardType(.numberPad)
        .autocapitalization(.none)
    }

    private var forgotPasswordButton: some View {
        Button(L10n.changePassword) {
            viewModel.changePasswordButtonTapped()
        }
        .buttonStyle(.primary())
        .disabled(viewModel.shouldDisableSignupButton())
    }
}
