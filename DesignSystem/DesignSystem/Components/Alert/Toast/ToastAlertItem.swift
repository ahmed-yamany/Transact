//
//  ToastAlertItem.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 07/11/2024.
//

import SwiftUI

public protocol ToastAlertItem: Identifiable, Equatable, Hashable {
    var image: Image { get }
    var title: Text { get }
    var message: Text? { get }

    var tintColor: Color { get }
}

public extension ToastAlertItem {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public struct AnyToastAlertItem: ToastAlertItem {
    public var id: AnyHashable
    public var image: Image
    public var title: Text
    public var message: Text?
    public var tintColor: Color

    public init<T: ToastAlertItem>(_ item: T) {
        id = AnyHashable(item.id)
        image = item.image
        title = item.title
        message = item.message
        tintColor = item.tintColor
    }
}

public struct ErrorToastAlertItem: ToastAlertItem {
    public var id = UUID()
    public var image: Image = DesignSystem.Foundation.Icons.xCircleFill.swiftUIImage.renderingMode(.template)
    public var title: Text
    public var message: Text?
    public var tintColor: Color = DesignSystem.Foundation.Colors.redDark.swiftUIColor

    public init(title: Text, message: Text? = nil) {
        self.title = title
        self.message = message
    }
}

public extension ToastAlertItem where Self == ErrorToastAlertItem {
    static func error(title: Text, message: Text? = nil) -> Self {
        ErrorToastAlertItem(title: title, message: message)
    }
}
