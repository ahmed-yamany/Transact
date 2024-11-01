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

}
