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
        RoutableNavigationStack(router: router) {
            Text("")
                .toolbar(.visible, for: .navigationBar)
        }
        .tint(.blue)
        .configureLanguageSettings(languageSettings)
        .task {
            try? await Task.sleep(for: .seconds(5))
            SplashFactoryContainer.coordinator(router: router).start()
        }
        .task {
            try? await Task.sleep(for: .seconds(15))
            if languageSettings.language == .arabic {
                languageSettings.language = .english
            } else {
                languageSettings.language = .arabic
            }
        }
    }

    func start() {
    }
}
