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
import Coordinator

enum TestEnum: Hashable, View {
    case a, b
    var body: some View {
        Text("Hello Ahmed")
    }
}

class TestClass: ObservableObject {
    @Published var stack: [TestEnum] = []
}

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TransactCoordinator()
        }
    }
}
