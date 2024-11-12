//
//  ToastAlertPresenterView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 13/11/2024.
//
import SwiftUI

public struct ToastAlertPresenterView: View {
    @ObservedObject var alertPresenter: AlertPresenterController
    let safeAreaInsets: EdgeInsets
    let rect: CGRect

    public init(_ alertPresenter: AlertPresenterController, safeAreaInsets: EdgeInsets, rect: CGRect) {
        _alertPresenter = ObservedObject(wrappedValue: alertPresenter)
        self.safeAreaInsets = safeAreaInsets
        self.rect = rect
    }

    public var body: some View {
        Group {
            if let toastItem = alertPresenter.toastAlert {
                ToastAlertView(toastItem)
                    .padding(.horizontal, DesignSystem.Foundation.Measurements.Padding.leading)
                    .position(CGPoint(x: rect.midX, y: safeAreaInsets.top))
                    .transition(.move(edge: .top))
                    .onTapGesture {
                        alertPresenter.toastAlert = nil
                    }
            }
        }
        .animation(.easeInOut, value: alertPresenter.toastAlert)
    }
}
