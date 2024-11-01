//
//  PrimaryTextFieldError.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import SwiftUI

public protocol PrimaryTextFieldError {
    var text: String { get }
    var color: Color { get }
}

public struct SuccessPrimaryTextFieldError: PrimaryTextFieldError {
    public var text: String
    public var color: Color = DesignSystem.Tokens.Colors.success

    init(text: String) {
        self.text = text
    }
}

public struct ErrorPrimaryTextFieldError: PrimaryTextFieldError {
    public var text: String
    public var color: Color = DesignSystem.Tokens.Colors.danger

    init(text: String) {
        self.text = text
    }
}

public extension PrimaryTextFieldError where Self == SuccessPrimaryTextFieldError {
    static func success(_ text: String) -> Self {
        .init(text: text)
    }
}

public extension PrimaryTextFieldError where Self == ErrorPrimaryTextFieldError {
    static func error(_ text: String) -> Self {
        .init(text: text)
    }
}
