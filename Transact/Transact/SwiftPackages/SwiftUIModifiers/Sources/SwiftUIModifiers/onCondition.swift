//
//  onCondition.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func onCondition(_ condition: Bool, _ modifer: (Self) -> some View) -> some View {
        if condition {
            AnyView(modifer(self))
        } else {
            AnyView(self)
        }
    }
}
