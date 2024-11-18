//
//  OnboardingUseCase.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Foundation

public protocol OnboardingUseCaseInterface {
    func getOnboardingModels() async throws -> [OnboardingEntity]
}

public actor OnboardingUseCase: OnboardingUseCaseInterface {
    internal let service: OnboardingServiceInterface

    public init(service: OnboardingServiceInterface) {
        self.service = service
    }

    public func getOnboardingModels() async throws -> [OnboardingEntity] {
        let models: [OnboardingModel] = try await service.getOnboardingModels()
        return models.map { OnboardingEntity(model: $0) }
    }
}
