//
//  BigButtonSize.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import Foundation

public struct BigButtonSize: ButtonSize {
    public var height: CGFloat? = 42
    public var cornerRadius: CGFloat = .borderRadius.xSmall
}

public extension ButtonSize where Self == BigButtonSize {
    static var big: Self {
        BigButtonSize()
    }
}

public extension DesignSystem.Foundation.Measurements {
    enum ButtonSize {
        public static var big = BigButtonSize()
        public static var small = SmallButtonSize()
    }
}
