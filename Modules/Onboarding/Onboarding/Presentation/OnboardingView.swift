//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import DesignSystem
import Localization
import SwiftUI

extension CGFloat {
    static var measurements = DesignSystem.Foundation.Measurements.self
}

extension Color {
    static var colors = DesignSystem.Tokens.Colors.self
}

public struct OnboardingView<ViewModel: OnboardingViewModelInterface>: View {
    @ObservedObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack {
            skipButton
                .frame(maxWidth: .infinity, alignment: .trailing)

            Spacer()

            VStack(spacing: .measurements.Spacing.xxLarge) {
                tabView
                paginationView
            }

            Spacer()

            Group {
                if viewModel.shouldShowGetStartedButton() {
                    HStack {
                        backButton
                        Spacer()
                        nextButton
                    }
                } else {
                    getStartedButton
                }
            }
            .frame(height: .measurements.ButtonSize.big.height)
        }
        .padding(CGFloat.measurements.Padding)
        .padding(.bottom, .measurements.Spacing.xxxLarge)

        .applyPrimaryDesign()
        .animation(.spring, value: viewModel.selectedIndex)
        .onAppear {
            viewModel.loadModels()
        }
    }

    private var skipButton: some View {
        Button {
            viewModel.skipOrRestartButtonTapped()
        } label: {
            P3Text(viewModel.skipOrRestartButtonTitle())
        }
        .buttonStyle(.text())
    }

    private var tabView: some View {
        TabView(selection: $viewModel.selectedIndex) {
            ForEach(viewModel.models.indices, id: \.self) { modelIndex in
                let model = viewModel.getModel(at: modelIndex)

                VStack {
                    Image(uiImage: model.image)
                        .resizable()
                        .frame(height: 240)
                        .aspectRatio(contentMode: .fit)
                        .flipsForRightToLeftLayoutDirection(true)

                    P2Text(model.description)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)
                }
                .padding(.horizontal, .measurements.Padding.leading)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.horizontal, -.measurements.Padding.leading)
    }

    private var paginationView: some View {
        PaginationView(count: viewModel.models.count, selectedIndex: viewModel.selectedIndex)
            .paginationStyle(.capsule(width: 40, height: 12))
            .paginationSelectFill(DesignSystem.Tokens.Colors.gradient)
    }

    private var nextButton: some View {
        Button {
            viewModel.nextButtonTapped()
        } label: {
            P3Text(L10n.next)
        }
        .buttonStyle(.text())
    }

    private var backButton: some View {
        Button {
            viewModel.backButtonTapped()
        } label: {
            P3Text(L10n.back)
        }
        .buttonStyle(.text())
        .disabled(viewModel.shouldDisableBackButton())
    }

    private var getStartedButton: some View {
        Button {
            viewModel.backButtonTapped()
        } label: {
            P3Text(L10n.getStarted)
        }
        .buttonStyle(.primary())
    }
}
