//
//  PaginationView.swift
//  Clarity
//
//  Created by Ahmed Yamany on 21/12/2023.
//

import SwiftUI

public struct PaginationView: View {
    let count: Int
    let selectedIndex: Int
    
    public init(count: Int, selectedIndex: Int) {
        self.count = count
        self.selectedIndex = selectedIndex
    }
    
    @Environment(\.paginationStyle) private var style
    
    public var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                AnyView(style.resolve(configurations: .init(currentIndex: index, selectedIndex: selectedIndex)))
            }
        }
        .animation(.spring, value: selectedIndex)
    }
}
