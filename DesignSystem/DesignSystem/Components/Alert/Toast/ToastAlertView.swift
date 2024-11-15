//
//  ToastAlertView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 10/11/2024.
//

import SwiftUI

struct ToastAlertView: View {
    @State private var dragXValue: CGFloat = 0

    let item: any ToastAlertItem
    let deleteAction: () -> Void

    init(_ item: any ToastAlertItem, deleteAction: @escaping () -> Void) {
        self.item = item
        self.deleteAction = deleteAction
    }

    var body: some View {
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
        .background(.ultraThinMaterial)
        .mask(shapeToClip)
        .background {
            shapeToClip
                .stroke(lineWidth: DesignSystem.Foundation.Measurements.BorderWidth.default)
                .fill(item.tintColor)
        }
        .offset(x: dragXValue)
        .gesture(
            DragGesture()
                .onChanged({ gestureValue in
                    dragXValue = gestureValue.translation.width < 0 ? gestureValue.translation.width : 0
                })
                .onEnded({ gestureValue in
                    if -gestureValue.translation.width > 200 {
                        deleteAction()
                    } else {
                        dragXValue = 0
                    }
                })
        )
        .animation(.bouncy, value: dragXValue)
    }

    private var shapeToClip: some Shape {
        RoundedRectangle(cornerRadius: DesignSystem.Foundation.Measurements.BorderRadius.xMedium)
    }
}
