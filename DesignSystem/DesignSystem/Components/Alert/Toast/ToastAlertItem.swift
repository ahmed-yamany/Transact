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

    var backgroundColor: Color { get }
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
    private let _image: () -> Image
    private let _title: () -> Text
    private let _message: () -> Text?
    private let _backgroundColor: () -> Color
    private let _tintColor: () -> Color
    private let _id: AnyHashable

    public var id: AnyHashable {
        _id
    }

    public var image: Image {
        _image()
    }

    public var title: Text {
        _title()
    }

    public var message: Text? {
        _message()
    }

    public var backgroundColor: Color {
        _backgroundColor()
    }

    public var tintColor: Color {
        _tintColor()
    }

    public init<T: ToastAlertItem>(_ item: T) {
        _image = { item.image }
        _title = { item.title }
        _message = { item.message }
        _backgroundColor = { item.backgroundColor }
        _tintColor = { item.tintColor }
        _id = AnyHashable(item.id)
    }
}


public struct ErrorToastAlertItem: ToastAlertItem {
    public var id = UUID()
    public var image: Image = DesignSystem.Foundation.Icons.xCircleFill.swiftUIImage.renderingMode(.template)
    public var title: Text
    public var message: Text?
    public var backgroundColor: Color = DesignSystem.Foundation.Colors.redDark.swiftUIColor.opacity(0.4)
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
