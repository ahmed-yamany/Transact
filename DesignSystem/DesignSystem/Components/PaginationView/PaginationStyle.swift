//
//  PaginationStyle.swift
//  Clarity
//
//  Created by Ahmed Yamany on 21/12/2023.
//

import SwiftUI

public struct PaginationConfigurations {
    let currentIndex: Int
    var selectedIndex: Int
}

public protocol PaginationStyle: DynamicProperty {
    associatedtype Body: View
    typealias Configurations = PaginationConfigurations

    @ViewBuilder
    func makeBody(configurations: Configurations) -> Body
}

public struct PaginationKey: EnvironmentKey {
    public static var defaultValue: any PaginationStyle = CirclePaginationStyle(height: 10)
}

public extension EnvironmentValues {
    var paginationStyle: any PaginationStyle {
        get { self[PaginationKey.self] }
        set { self[PaginationKey.self] = newValue }
    }
}

public extension View {
    func paginationStyle(_ style: any PaginationStyle) -> some View {
        environment(\.paginationStyle, style)
    }
}

public struct ResolvedPaginationStyle<Style: PaginationStyle>: View {
    var configurations: Style.Configurations
    var style: Style

    init(configurations: Style.Configurations, style: Style) {
        self.configurations = configurations
        self.style = style
    }

    public var body: some View {
        style.makeBody(configurations: configurations)
    }
}

public extension PaginationStyle {
    func resolve(configurations: Configurations) -> some View {
        ResolvedPaginationStyle(configurations: configurations, style: self)
    }
}

public struct PaginationSelectFillViewKey: EnvironmentKey {
    public static var defaultValue: AnyView = AnyView(Color.blue)
}

public struct PaginationFillViewKey: EnvironmentKey {
    public static var defaultValue: AnyView = AnyView(Color.gray)
}

public extension EnvironmentValues {
    var paginationSelectFillView: AnyView {
        get { self[PaginationSelectFillViewKey.self] }
        set { self[PaginationSelectFillViewKey.self] = newValue }
    }

    var paginationFillView: AnyView {
        get { self[PaginationFillViewKey.self] }
        set { self[PaginationFillViewKey.self] = newValue }
    }
}

public extension View {
    func paginationSelectFill(_ view: some View) -> some View {
        environment(\.paginationSelectFillView, AnyView(view))
    }

    func paginationFill(_ view: some View) -> some View {
        environment(\.paginationFillView, AnyView(view))
    }
}
