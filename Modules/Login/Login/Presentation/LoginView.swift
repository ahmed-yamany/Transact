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
                AuthenticationView(title: L10n.welcomeBack, subtitle: L10n.Login.subtitle)

                PrimaryTextField("Enter Username", title: "Username", text: $viewModel.phoneNumber)

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

    private var loginButton: some View {
        Button(L10n.login) {
        }
        .buttonStyle(.primary())
    }

    private var forgotPasswordButton: some View {
        Button(L10n.forgotPassword) {
        }
        .buttonStyle(.text())
    }

    private var signupView: some View {
        HStack {
            P3Text(L10n.dontHaveAccount)

            Button(L10n.signup) {
            }
            .buttonStyle(.text())
        }
    }
}
