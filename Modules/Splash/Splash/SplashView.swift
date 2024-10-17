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
        DesignSystem.Tokens.Colors.gradient.ignoresSafeArea()
            .overlay {
                LogoView()
            }
            .task {
                try? await Task.sleep(for: .seconds(5))
                coordinator.splashViewEnded()
            }
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
