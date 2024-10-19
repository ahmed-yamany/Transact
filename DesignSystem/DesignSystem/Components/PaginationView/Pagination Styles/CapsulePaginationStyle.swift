//
//  CapsulePaginationStyle.swift
//  Clarity
//
//  Created by Ahmed Yamany on 21/12/2023.
//

import SwiftUI

public struct CapsulePaginationStyle: PaginationStyle {
    @Environment(\.paginationFillView) private var fill: AnyView
    @Environment(\.paginationSelectFillView) private var selectedFill: AnyView
    
    private let width: CGFloat
    private let height: CGFloat
    
    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    public func makeBody(configurations: Configurations) -> some View {
        let isSelected = configurations.currentIndex == configurations.selectedIndex
        Group {
            isSelected ? selectedFill : fill
        }
        .mask {
            RoundedRectangle(cornerRadius: height / 2)
        }
        .frame(width: isSelected ? width : height, height: height)
    }
}

public extension PaginationStyle where Self == CapsulePaginationStyle {
    static func capsule(width: CGFloat = 30, height: CGFloat = 10) -> Self {
        CapsulePaginationStyle(width: width, height: height)
    }
}
