//
//  TransactApp.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import SwiftUIViews
import DesignSystem
import Splash

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var languageSettings = LanguageSettings.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView(coordinator: SplashFactoryContainer.coordinator())
//            NavigationControllerView(
//                navigationController: TransactFactoryContainer.refreshAppCoordinator().router.navigationController
//            )
//            .viewDidLoad {
//                TransactFactoryContainer.appCoordinator.start()
//            }
//            .configureLanguageSettings(languageSettings)
        }
    }
}
