//
//  VariableAlertPresenterView.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 15/11/2024.
//
import SwiftUI

@available(iOS 16.4, *)
public extension View {
    @ViewBuilder
    func variableAlertPresenter(_ item: Binding<AnyVariableAlertItem?>) -> some View {
        sheet(item: item) { item in
            VariableAlertPresenterView(item)
        }
    }
}

@available(iOS 16.4, *)
struct VariableAlertPresenterView<Item: VariableAlertItem>: View {
    private let item: Item

    public init(_ item: Item) {
        self.item = item
    }

    public var body: some View {
        VariableAlertView(item)
            .ignoresSafeArea()
            .presentationDetents([.fraction(0.35)])
            .presentationCornerRadius(50)
            .presentationDragIndicator(.visible)
    }
}
