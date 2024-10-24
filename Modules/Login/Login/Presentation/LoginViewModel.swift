//
//  LoginViewModel.swift
//  Login
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Combine
import SwiftUI

@MainActor
public protocol LoginViewModelInterface: ObservableObject {
    var phoneNumber: String { get set }
}

@MainActor
public final class LoginViewModel: LoginViewModelInterface {
    @Published public var phoneNumber: String = ""
    
    public let coordinator: LoginCoordinatorInterface
    
    public init(coordinator: LoginCoordinatorInterface) {
        self.coordinator = coordinator
    }
}
