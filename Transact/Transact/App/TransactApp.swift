//
//  TransactApp.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import SwiftUIViews
import SwiftUIModifiers
import DesignSystem
import Splash

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var settings = SettingsFactoryContainer.settings
    
    var body: some Scene {
        WindowGroup {
            NavigationControllerView(
                navigationController: TransactFactoryContainer.refreshAppCoordinator().router.navigationController
            )
            .viewDidLoad {
                TransactFactoryContainer.appCoordinator.start()
            }
            .environmentSettings(settings)
        }
    }
}
