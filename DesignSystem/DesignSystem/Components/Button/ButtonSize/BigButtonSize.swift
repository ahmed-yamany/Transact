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
