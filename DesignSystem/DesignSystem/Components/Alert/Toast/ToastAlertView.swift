//
//  ToastAlertView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 10/11/2024.
//

import SwiftUI

public struct ToastAlertView: View {
    let item: any ToastAlertItem

    public init(_ item: any ToastAlertItem) {
        self.item = item
    }

    public var body: some View {
        HStack(alignment: .top, spacing: .spacing.medium) {
            item.image
                .resizable()
                .foregroundStyle(item.tintColor)
                .frame(width: 20, height: 20)

            VStack(alignment: .leading, spacing: .spacing.xxSmall) {
                H4Text(item.title)
                    .font(.title)
                    .foregroundStyle(DesignSystem.Tokens.Colors.primaryText)

                P2Text(item.message ?? Text(""))
                    .foregroundStyle(DesignSystem.Tokens.Colors.secondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.spacing.medium)
        .frame(height: 78)
        .frame(maxWidth: .infinity)
        .background(item.backgroundColor)
        .mask(shapeToClip)
        .background {
            shapeToClip
                .stroke(lineWidth: DesignSystem.Foundation.Measurements.BorderWidth.default)
                .fill(item.tintColor)
        }
    }

    private var shapeToClip: some Shape {
        RoundedRectangle(cornerRadius: DesignSystem.Foundation.Measurements.BorderRadius.xMedium)
    }
}
