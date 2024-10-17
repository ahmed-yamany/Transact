//
//  AuthenticationFlowCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import SwiftUI
import Coordinator

struct AuthenticationFlowCoordinator: View {
    @StateObject var router = TransactFactoryContainer.router()

    var body: some View {
        RoutableNavigationStack(router: router)
    }
}
