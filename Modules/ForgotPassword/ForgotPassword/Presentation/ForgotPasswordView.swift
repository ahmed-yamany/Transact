//
//  ForgotPasswordView.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import SwiftUI

public struct ForgotPasswordView<ViewModel: ForgotPasswordViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Text("Forgot Password View")
    }
}
