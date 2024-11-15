//
//  AlertPresenterController.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 12/11/2024.
//
import SwiftUI

public final class AlertPresenterController: AlertPresenter, ObservableObject {
    @Published public var toastAlerts: [AnyToastAlertItem] = []
    @Published public var variableAlert: AnyVariableAlertItem? = nil

    public init() {}

    public func presentAlert(_ alert: AlertType, _ completion: (() -> Void)?) {
        switch alert {
        case let .toast(toastAlertItem):
            toastAlerts.append(AnyToastAlertItem(toastAlertItem))
        case let .variable(variableAlertItem):
            variableAlert = AnyVariableAlertItem(variableAlertItem)
        }
    }
}
