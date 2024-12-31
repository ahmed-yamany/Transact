//
//  AnyRoutableView.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import SwiftUI

public struct AnyHashableView: View, Hashable, Identifiable {
    private let _view: AnyView
    public var id: UUID = UUID()
    public var type: Any.Type

    public init<T: View>(_ routableView: T) {
        _view = AnyView(routableView)
        type = T.self
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: AnyHashableView, rhs: AnyHashableView) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public var body: some View {
        _view
    }
}
