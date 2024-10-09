//
//  ColorTokens.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 23/09/2024.
//

import SwiftUI

extension DesignSystem.Tokens {
    enum Colors { }
}

extension DesignSystem.Tokens.Colors {
    static var gradient: LinearGradient {
        LinearGradient(
            colors: [
                DesignSystem.Foundation.Colors.blueDark.swiftUIColor,
                DesignSystem.Foundation.Colors.blueNormal.swiftUIColor
            ],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
    
    static var background: Color {
        DesignSystem.Foundation.Colors.whiteDarker.swiftUIColor
    }
    
    static var offBackground: Color {
        DesignSystem.Foundation.Colors.cloudNormal.swiftUIColor
    }
    
    static var primaryText: Color {
        DesignSystem.Foundation.Colors.inkDarkActive.swiftUIColor
    }
    
    static var secondaryText: Color {
        DesignSystem.Foundation.Colors.inkDark.swiftUIColor
    }
    
    static var inactive: Color {
        DesignSystem.Foundation.Colors.cloudNormalActive.swiftUIColor
    }
    
    static var actionAndInfo: Color {
        DesignSystem.Foundation.Colors.blueNormalActive.swiftUIColor
    }
    
    static var danger: Color {
        DesignSystem.Foundation.Colors.redNormal.swiftUIColor
    }
    
    static var success: Color {
        DesignSystem.Foundation.Colors.greenNormal.swiftUIColor
    }
    
    static var warning: Color {
        DesignSystem.Foundation.Colors.orangeNormal.swiftUIColor
    }
    
    static var mobileBG: Color {
        .white
    }

}
