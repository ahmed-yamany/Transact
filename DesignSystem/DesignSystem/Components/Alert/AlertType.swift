//
//  AlertType.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 12/11/2024.
//
import Foundation

public enum AlertType {
    case toast(any ToastAlertItem)
    case variable(any VariableAlertItem)
}
