//
//  TransactCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import SwiftUIViews
import Localization
import Coordinator

protocol TransactCoordinatorProtocol {
    
}

struct TransactCoordinator: View {
    @ObservedObject var languageSettings = LocalizationSettings.shared
    @StateObject var router = TransactFactoryContainer.router()
    
    var body: some View {
        RoutableNavigationStack(router: router)
            .tint(.blue)
            .configureLanguageSettings(languageSettings)
            .onAppear {
                SplashFactoryContainer.coordinator(router: router).start()
            }
    }
}
