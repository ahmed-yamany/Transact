//
//  LoginView.swift
//  Login
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import DesignSystem
import Localization
import SwiftUI

public struct LoginView<ViewModel: LoginViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: .measurements.Spacing.xxxLarge) {
                AuthenticationView(title: L10n.Localizable.welcomeBack, subtitle: L10n.Login.subtitle)

                VStack(spacing: .measurements.Spacing.large) {
                    phoneNumberTextField

                    passworedTextField

                    rememberMe
                }

                VStack(spacing: .measurements.Spacing.large) {
                    loginButton

                    VStack(spacing: .measurements.Spacing.xSmall) {
                        signupView

                        forgotPasswordButton

                        TermsConditionsView()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(CGFloat.measurements.Padding)
        }
        .applyPrimaryDesign()
    }

    private var phoneNumberTextField: some View {
        PrimaryTextField(
            L10n.Localizable.enterPhoneNumber,
            title: L10n.Localizable.phoneNumber,
            text: $viewModel.phoneNumber
        )
        .keyboardType(.numberPad)
        .autocapitalization(.none)
    }

    private var passworedTextField: some View {
        PrimaryTextField(
            L10n.Localizable.enterPassword,
            title: L10n.Localizable.password,
            text: $viewModel.password,
            secured: true
        )
        .autocapitalization(.none)
    }

    private var rememberMe: some View {
        Toggle(isOn: $viewModel.rememberMe) {
            P4Text(L10n.Localizable.rememberMe)
        }
        .toggleStyle(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var loginButton: some View {
        Button(L10n.Localizable.login) {
            viewModel.loginButtonTapped()
        }
        .buttonStyle(.primary())
    }

    private var forgotPasswordButton: some View {
        Button(L10n.Localizable.forgotPassword) {
            viewModel.forgotPasswordButtonTapped()
        }
        .buttonStyle(.text())
    }

    private var signupView: some View {
        HStack {
            P3Text(L10n.Localizable.dontHaveAccount)

            Button(L10n.Localizable.signup) {
                viewModel.signupButtonTapped()
            }
            .buttonStyle(.text())
        }
    }
}
