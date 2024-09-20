//
//  View+border.swift
//
//
//  Created by Ahmed Yamany on 28/07/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func border(_ color: Color, lineWidth: CGFloat, radius: CGFloat = 0) -> some View {
        mask {
            RoundedRectangle(cornerRadius: radius)
        }
        .background {
            RoundedRectangle(cornerRadius: radius)
                .stroke(lineWidth: lineWidth)
                .fill(color)
        }
    }
}
