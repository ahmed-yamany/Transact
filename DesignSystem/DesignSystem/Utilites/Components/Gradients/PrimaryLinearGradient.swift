//
//  PrimaryLinearGradient.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI
import UIExtensions

public var PrimaryLinearGradient = {
    LinearGradient(
        colors: [
            Color(uiColor: UIColor(hexString: "2754C8")),
            Color(uiColor: UIColor(hexString: "110F72"))
        ],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
}
