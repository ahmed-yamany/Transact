//
//  ToastAlertPresenter.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 13/11/2024.
//
import SwiftUI

@available(iOS 16.0, *)
public extension View {
    @ViewBuilder
    func toastAlertPresenter(_ toasts: Binding<[AnyToastAlertItem]>) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .top) {
                ToastsAlertView(toasts)
            }
    }
}

@available(iOS 16.0, *)
private struct ToastsAlertView: View {
    @Binding var toasts: [AnyToastAlertItem]
    @State private var isExpanded: Bool = false

    init(_ toasts: Binding<[AnyToastAlertItem]>) {
        _toasts = toasts
    }

    var body: some View {
        ZStack(alignment: .top) {
            if isExpanded {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isExpanded = false
                    }
            }

            let layout = isExpanded ? AnyLayout(VStackLayout(spacing: .spacing.small)) : AnyLayout(ZStackLayout())

            layout {
                ForEach(toasts) { toast in
                    let index = toasts.firstIndex(of: toast) ?? 0

                    ToastAlertView(toast, deleteAction: {
                        toasts.removeAll(where: { $0 == toast })
                    })
                    .offset(y: isExpanded ? 1 : offset(index))
                    .transition(.asymmetric(insertion: .offset(y: -100), removal: .push(from: .trailing)))
                    .onTapGesture {
                        isExpanded.toggle()
                    }
                }
                .padding(.horizontal, DesignSystem.Foundation.Measurements.Padding.leading)
            }
        }
        .animation(.bouncy, value: isExpanded)
        .animation(.easeInOut, value: toasts)
        .onChange(of: toasts.isEmpty) { newValue in
            if newValue {
                isExpanded = false
            }
        }
    }

    func offset(_ index: Int) -> CGFloat {
        CGFloat(min(index * 15, 30))
    }
}
