//
//  AlertPresenter.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 07/11/2024.
//

import Foundation

@MainActor
public protocol AlertPresenter {
    func presentAlert(_ alert: AlertType, _ completion: (() -> Void)?)
//    func dissmisAlert(_ completion: (() -> Void)?)
}

@MainActor
public extension AlertPresenter {
    func presentAlert(_ alert: AlertType, _ completion: (() -> Void)? = nil) {
        presentAlert(alert, completion)
    }

//    func dissmisAlert(_ completion: (() -> Void)? = nil) {
//        dissmisAlert(completion)
//    }
}
