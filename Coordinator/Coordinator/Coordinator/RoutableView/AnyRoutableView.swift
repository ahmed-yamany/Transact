//
//  AnyRoutableView.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import SwiftUI

public struct AnyRoutableView: View, Hashable, Identifiable {
    
    private let _view: AnyView
    private let _hashValue: Int
    public var id: UUID
    
    public init<T: RoutableView>(_ routableView: T) {
        self._view = AnyView(routableView)
        self._hashValue = routableView.hashValue
        id = routableView.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_hashValue)
        hasher.combine(id)
    }

    public static func == (lhs: AnyRoutableView, rhs: AnyRoutableView) -> Bool {
        lhs.hashValue == rhs.hashValue && lhs.id == rhs.id
    }

    public var body: some View {
        _view
    }
}
