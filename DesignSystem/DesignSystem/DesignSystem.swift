//
//  DesignSystem.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import Foundation

public enum DesignSystem {
    public enum Foundation {}
    public enum Tokens {}
}

public extension DesignSystem.Foundation {
    static let Colors = FoundationColors.self
    static let Typography = FontFamily.self
    static let Icons = FoundationIcons.self
    enum Measurements {}
}
