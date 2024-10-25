//
//  SplashCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import Coordinator
import Splash
import SwiftUI

struct SplashCoordinator: SplashCoordinatorInterface, View {
    let view: (SplashCoordinatorInterface) -> AnyView
    let splashEnded: () -> Void

    init(splashEnded: @escaping () -> Void, view: @escaping (SplashCoordinatorInterface) -> AnyView) {
        self.view = view
        self.splashEnded = splashEnded
    }

    var body: some View {
        view(self)
    }

    func splashViewEnded() {
        splashEnded()
    }
}
