//
//  VariableAlertItem.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 12/11/2024.
//

import SwiftUI

public struct VariableAlertItem: Identifiable, Equatable, Hashable {
    public var id = UUID()
    public let image: Image
    public let title: Text
    public let message: Text?
    public let primaryAction: () -> Void
    public let secondaryAction: () -> Void

    public init(
        image: Image,
        title: Text,
        message: Text? = nil,
        primaryAction: @escaping () -> Void,
        secondaryAction: @escaping () -> Void
    ) {
        self.image = image
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: VariableAlertItem, rhs: VariableAlertItem) -> Bool {
        lhs.id == rhs.id
    }
}
