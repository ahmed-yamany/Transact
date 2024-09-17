//
//  TransactApp.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import SwiftUIViews

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var appCoordinator = TransactFactoryContainer.appCoordinator
    
    var body: some Scene {
        WindowGroup {
            NavigationControllerView(navigationController: appCoordinator.router.navigationController)
        }
    }
}
