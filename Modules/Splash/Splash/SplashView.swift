//
//  SplashView.swift
//  Splash
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import DesignSystem

public struct SplashView: View {
    let coordinator: SplashCoordinatorInterface
    
    public init(coordinator: SplashCoordinatorInterface) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack {
            VStack(spacing: 8) {
                Asset.Images.logo.swiftUIImage
                    .resizable()
                    .frame(width: 56, height: 56)
                
                Text(.h3Label(text: L10n.appName, color: ColorTokens.mobileBG))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(PrimaryLinearGradient())
        .task {
            try? await Task.sleep(for: .seconds(3))
            coordinator.splashViewEnded()
        }
    }
}
