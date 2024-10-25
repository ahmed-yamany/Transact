//
//  LoginUseCase.swift
//  Login
//
//  Created by Ahmed Yamany on 25/10/2024.
//

import Foundation

public protocol LoginUseCaseInterface {
    func login(_ model: LoginModel) async throws -> Void
}

public final actor LoginUseCase: LoginUseCaseInterface {
    let service: LoginServiceInterface

    public init(service: LoginServiceInterface) {
        self.service = service
    }

    public func login(_ model: LoginModel) async throws {
        try await service.login(model)
    }
}
