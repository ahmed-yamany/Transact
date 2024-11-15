//
//  OnboardingErrorVariableAlertItem.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 15/11/2024.
//

import DesignSystem
import SwiftUI

struct OnboardingErrorVariableAlertItem: VariableAlertItem {
    var id = UUID()
    var image: Image = DesignSystem.Foundation.Icons.notificationsFill.swiftUIImage
    var title: Text = Text("Error Occured")
    var message: Text?
    var primaryButton: VariableButton { .init(Text("Reload"), action: realoadAction) }
    var secondaryButton: VariableButton?

    let realoadAction: () -> Void

    init(message: String, realoadAction: @escaping () -> Void) {
        self.message = Text(message)
        self.realoadAction = realoadAction
    }
}
