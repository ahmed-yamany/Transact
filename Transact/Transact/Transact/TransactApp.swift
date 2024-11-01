//
//  TransactApp.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = TransactFactoryContainer.viewModel()

    var body: some Scene {
        WindowGroup {
            TransactCoordinator(viewModel: viewModel)
        }
    }
}