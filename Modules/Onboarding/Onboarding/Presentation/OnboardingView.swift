//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI
import DesignSystem

public struct OnboardingView<ViewModel: OnboardingViewModelInterface>: View {
    @ObservedObject var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                skipButton
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                tabView
                
                navigateButtons
            }
            .frame(maxWidth: .infinity)
//            .padding(.horizontal, Measurements.padding)
        }
        .applyPrimaryDesign()
    }
    
    private var skipButton: some View {
        Button {
            viewModel.skipButtonTapped()
        } label: {
            Text(L10n.skip)
        }
        .buttonStyle(.labelButton())
        
    }
    
    private var tabView: some View {
        TabView(selection: $viewModel.currentTabViewIndex) {
            ForEach(viewModel.tabViewModels.indices, id: \.self) { index in
                let model = viewModel.tabViewModels[index]
                VStack(spacing: 44) {
//                    Image(uiImage: model.image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 220)
//                    
//                    VStack(spacing: 12) {
//                        Text(model.title)
//                            .multilineTextAlignment(.center)
//                            .font(FontFamily.Poppins.semiBold.swiftUIFont(size: 24))
//                        
//                        Text(model.description)
//                            .multilineTextAlignment(.center)
//                            .font(FontFamily.Poppins.regular.swiftUIFont(size: 14))
//                            .padding(.horizontal, 30)
//                    }
//                    .foregroundStyle(Asset.Colors.erContentPrimary.swiftUIColor)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 14)
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    private var navigateButtons: some View {
        HStack {
            Button {
                viewModel.backButtonTapped()
            } label: {
                Text(L10n.back)
            }
            .buttonStyle(.labelButton())
            .disabled(!viewModel.enableBackButton)
            
            Spacer()
            
            Button {
                viewModel.nextButtonTapped()
            } label: {
                Text(L10n.next)
            }
            .buttonStyle(.labelButton())
        }
    }
}
