//
//  View+alwaysPopover.swift
//  Labothécaire
//
//  Created by Ahmed Yamany on 29/07/2024.
//

import SwiftUI

public extension View {
    func alwaysPopover<Content>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        self.modifier(AlwaysPopoverModifier(isPresented: isPresented, contentBlock: content))
    }
}
