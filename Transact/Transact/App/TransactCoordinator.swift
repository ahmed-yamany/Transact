//
//  TransactCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import SwiftUIViews
import DesignSystem
import Coordinator

protocol TransactCoordinatorProtocol {
    
}

struct TransactCoordinator: View {
    @ObservedObject var languageSettings = LanguageSettings.shared
    @StateObject var router = TransactFactoryContainer.router()
    
    var body: some View {
        RoutableNavigationStack(router: router)
            .tint(.blue)
            .onAppear {
                SplashFactoryContainer.coordinator(router: router).start()
            }
    }

    func start() {
    }
}
