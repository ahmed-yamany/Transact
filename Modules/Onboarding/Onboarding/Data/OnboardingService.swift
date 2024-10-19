//
//  OnboardingService.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Foundation

public protocol OnboardingServiceInterface {
    func getOnboardingModels() async throws -> [OnboardingModel]
}
