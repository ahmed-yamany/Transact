//
//  LogoView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import SwiftUI
import Localization

public struct WhiteLogoView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: DesignSystem.Foundation.Measurements.Spacing.xSmall) {
            DesignSystem.Foundation.Assets.logoWhite.swiftUIImage
                .resizable()
                .frame(width: 56, height: 56)
            
            H4Text(L10n.appName)
                .foregroundStyle(DesignSystem.Tokens.Colors.mobileBG)
        }
    }
}
