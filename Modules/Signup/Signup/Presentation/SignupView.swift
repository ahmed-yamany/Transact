//
//  SignupView.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import SwiftUI

public struct SignupView<ViewModel: SignupViewModelInterface>: View {
    @ObservedObject private var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(initialValue: viewModel)
    }
    
    public var body: some View {
        Text("Signup")
    }
}
