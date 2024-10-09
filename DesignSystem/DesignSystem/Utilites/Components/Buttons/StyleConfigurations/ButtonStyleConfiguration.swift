//
//  ButtonStyleConfiguration.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI

public protocol ButtonBorderConfigurations {
    var color: Color { get }
    var lineWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
}

public protocol ButtonBackgroundConfigurations {
    var background: LinearGradient { get }
    var isPressedBackground: Color { get }
    var disabledBackground: Color { get }
}

public protocol ButtonForegroundConfigurations {
    var foregroundColor: Color { get }
    var isPressedForegroundColor: Color { get }
    var disabledForegroundColor: Color { get }
}

public protocol ButtonStyleConfigurations {
    var font: Font { get }
    var foreground: ButtonForegroundConfigurations { get }
    var background: ButtonBackgroundConfigurations? { get }
    var border: ButtonBorderConfigurations? { get }
    var size: ButtonSize? { get }
}
