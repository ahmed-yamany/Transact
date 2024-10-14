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
                H1Text(L10n.name)
                
                Button {
                    coordinator.splashViewEnded()
                } label: {
                    P1Text("Sign in")
                }
                .buttonStyle(PrimaryButtonStyle(size: .big))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, DesignSystem.Foundation.Measurements.Padding.left)
    }
}

struct SplashCoordinatorMock: SplashCoordinatorInterface {
    func splashViewEnded() {
        print("Splash View Ended")
    }
}

#Preview {
    SplashView(coordinator: SplashCoordinatorMock())
}
