//
//  View+onCondition.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 31/12/2024.
//
import SwiftUI

internal extension View {
    @ViewBuilder
    func onCondition(_ condition: Bool, _ modifer: (Self) -> some View) -> some View {
        if condition {
            AnyView(modifer(self))
        } else {
            AnyView(self)
        }
    }
}
