//
//  BlueLogoView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import SwiftUI
import Localization

public struct BlueLogoView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: DesignSystem.Foundation.Measurements.Spacing.xSmall) {
            DesignSystem.Foundation.Assets.logoBlue.swiftUIImage
                .resizable()
                .frame(width: 56, height: 56)
            
            H4Text(L10n.Localizable.appName)
                .foregroundStyle(DesignSystem.Tokens.Colors.gradient)
        }
    }
}
