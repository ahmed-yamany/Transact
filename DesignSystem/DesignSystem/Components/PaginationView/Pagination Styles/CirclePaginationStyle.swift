//
//  CirclePaginationStyle.swift
//  Clarity
//
//  Created by Ahmed Yamany on 21/12/2023.
//

import SwiftUI

public struct CirclePaginationStyle: PaginationStyle {
    @Environment(\.paginationFillView) private var fill: AnyView
    @Environment(\.paginationSelectFillView) private var selectedFill: AnyView

    let height: CGFloat

    public init(height: CGFloat) {
        self.height = height
    }

    public func makeBody(configurations: Configurations) -> some View {
        Group {
            configurations.currentIndex == configurations.selectedIndex ? selectedFill : fill
        }
        .mask {
            RoundedRectangle(cornerRadius: 5)
        }
        .frame(width: height, height: height)
    }
}

public extension PaginationStyle where Self == CirclePaginationStyle {
    static func circle(height: CGFloat = 10) -> Self {
        CirclePaginationStyle(height: height)
    }
}
