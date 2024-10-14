//
//  View+border.swift
//
//
//  Created by Ahmed Yamany on 28/07/2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func border(_ color: Color, lineWidth: CGFloat, radius: CGFloat? = nil) -> some View {
        mask {
            RoundedRectangle(cornerRadius: radius ?? 0)
        }
        .background {
            RoundedRectangle(cornerRadius: radius ?? 0)
                .stroke(lineWidth: lineWidth)
                .fill(color)
        }
    }
}
