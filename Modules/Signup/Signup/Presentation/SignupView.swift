//
//  SignupView.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import DesignSystem
import Localization
import SwiftUI

public struct SignupView<ViewModel: SignupViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = ObservedObject(initialValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: .measurements.Spacing.xxxLarge) {
                AuthenticationView(title: L10n.welcomeToTransact, subtitle: L10n.Signup.subtitle)

                VStack(spacing: .measurements.Spacing.large) {
                    phoneNumberTextField

                    fullNameTextField

                }

                VStack(spacing: .measurements.Spacing.large) {
                    signupButton

                    VStack(spacing: .measurements.Spacing.xSmall) {
                        signinView

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
            L10n.enterPhoneNumber,
            title: L10n.phoneNumber,
            text: $viewModel.phoneNumber
        )
        .keyboardType(.numberPad)
        .autocapitalization(.none)
    }

    private var fullNameTextField: some View {
        PrimaryTextField(
            L10n.enterYourFullName,
            title: L10n.fullName,
            text: $viewModel.fullName
        )
        .autocapitalization(.none)
    }



    private var signupButton: some View {
        Button(L10n.signup) {
            viewModel.signupButtonTapped()
        }
        .buttonStyle(.primary())
    }

    private var forgotPasswordButton: some View {
        Button(L10n.forgotPassword) {
            viewModel.forgotPasswordButtonTapped()
        }
        .buttonStyle(.text())
    }

    private var signinView: some View {
        HStack {
            P3Text(L10n.alreadyHaveAccount)

            Button(L10n.login) {
                viewModel.loginButtonTapped()
            }
            .buttonStyle(.text())
        }
    }
}
