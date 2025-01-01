//
//  PasswordView.swift
//  Password
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import DesignSystem
import Localization
import SwiftUI

public struct PasswordView<ViewModel: PasswordViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel
    private let content: PasswordContentInterFace

    public init(viewModel: ViewModel, content: PasswordContentInterFace) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: .measurements.Spacing.xxxLarge) {
                AuthenticationView(title: content.title, subtitle: content.subtitle)

                VStack(spacing: .measurements.Spacing.xMedium) {
                    passworedTextField
                    confirmPassworedTextField
                }

                completeButton

                VStack(spacing: .measurements.Spacing.xxxLarge) {
                    TermsConditionsView()
                }
                .padding(.bottom, .measurements.Spacing.xxxLarge)
            }
            .frame(maxWidth: .infinity)
            .padding(CGFloat.measurements.Padding)
        }

        .applyPrimaryDesign()
    }

    private var passworedTextField: some View {
        PrimaryTextField(
            L10n.Localizable.enterPassword,
            title: L10n.Localizable.password,
            text: $viewModel.password,
            error: viewModel.passwordError, secured: true,
            tip: content.passwordTip
        )
        .autocapitalization(.none)
        .keyboardType(.default)
    }

    private var confirmPassworedTextField: some View {
        PrimaryTextField(
            L10n.Localizable.enterPassword,
            title: L10n.Localizable.password,
            text: $viewModel.confirmPassword,
            error: viewModel.confirmPasswordError,
            secured: true
        )
        .autocapitalization(.none)
        .keyboardType(.default)
    }

    private var completeButton: some View {
        Button(L10n.Localizable.complete) {
            viewModel.completeButtonTapped()
        }
        .buttonStyle(.primary())
        .disabled(viewModel.shouldDisableSignupButton())
    }
}
