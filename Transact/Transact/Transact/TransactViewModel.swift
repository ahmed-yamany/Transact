//
//  TransactViewModel.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import SwiftUI

@MainActor
protocol TransactViewModelInterface: ObservableObject {
    var flow: TransactFlow { get set }
    
    func checkAuthentication()
}

@MainActor
final class TransactViewModel: TransactViewModelInterface {
    @Published var flow: TransactFlow = .splash
    
    func checkAuthentication() {
        flow = .onboarding
    }
}
