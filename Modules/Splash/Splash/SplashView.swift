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
        HStack {
            Text(L10n.appName)
            
            Image(systemName: "house")
        }
        .background(.blue)
    }
}
