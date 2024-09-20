//
//  eraseToAnyView.swift
//
//
//  Created by Ahmed Yamany on 04/05/2024.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
