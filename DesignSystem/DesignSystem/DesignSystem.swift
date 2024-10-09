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
    enum Typography { }
    static let Icons = FoundationIcons.self
    enum Measurements {}
}

public extension DesignSystem.Foundation.Measurements {
    enum Font {}
}
