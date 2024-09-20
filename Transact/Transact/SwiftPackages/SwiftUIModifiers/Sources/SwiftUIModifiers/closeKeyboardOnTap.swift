//
//  closeKeyboardOnTap.swift
//
//
//  Created by Ahmed Yamany on 23/04/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func closeKeyboardOnTap() -> some View {
        onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }
}
