//
//  SmallButtonSize.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import Foundation

public struct SmallButtonSize: ButtonSize {
    public var height: CGFloat? = 32
    public var cornerRadius: CGFloat = 4
}

public extension ButtonSize where Self == SmallButtonSize {
    static var small: Self {
        SmallButtonSize()
    }
}
