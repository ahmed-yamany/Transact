//
//  isHidden.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

public extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    @ViewBuilder 
    func isHidden(_ hidden: Bool) -> some View {
        onCondition(hidden) { $0.hidden() }
    }
}

