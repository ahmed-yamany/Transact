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
            .configureLanguageSettings(languageSettings)
            .onAppear {
                SplashFactoryContainer.coordinator(router: router).start()
            }
            .task {
                try? await Task.sleep(for: .seconds(3))
                router.present(
                    Text("Hello"),
                    animated: false,
                    presentationStyle: .formSheet,
                    transitionStyle: .coverVertical,
                    completion: nil
                )
                
                try? await Task.sleep(for: .seconds(3))
                router.present(
                    Text("Ahmed Yamany"),
                    animated: true,
                    presentationStyle: .formSheet,
                    transitionStyle: .coverVertical,
                    completion: nil
                )
            }
    }

    func start() {
    }
}
