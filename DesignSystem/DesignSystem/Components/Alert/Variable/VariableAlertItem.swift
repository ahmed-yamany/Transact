//
//  VariableAlertItem.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 12/11/2024.
//

import SwiftUI

public struct VariableButton {
    let title: Text
    let action: () -> Void

    public init(_ title: Text, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

public protocol VariableAlertItem: Identifiable, Equatable, Hashable {
    var image: Image { get }
    var title: Text { get }
    var message: Text? { get }
    var primaryButton: VariableButton { get }
    var secondaryButton: VariableButton? { get }
}

public extension VariableAlertItem {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public struct AnyVariableAlertItem: VariableAlertItem {
    public var id: AnyHashable
    public var image: Image
    public var title: Text
    public var message: Text?
    public var primaryButton: VariableButton
    public var secondaryButton: VariableButton?

    public init<T: VariableAlertItem>(_ item: T) {
        id = AnyHashable(item.id)
        image = item.image
        title = item.title
        message = item.message
        primaryButton = item.primaryButton
        secondaryButton = item.secondaryButton
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: AnyVariableAlertItem, rhs: AnyVariableAlertItem) -> Bool {
        lhs.id == rhs.id
    }
}
