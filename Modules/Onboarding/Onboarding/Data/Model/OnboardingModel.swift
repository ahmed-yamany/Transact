//
//  OnboardingModel.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Foundation

public struct OnboardingModel: Codable {
    public let image: Data?
    public let description: String?
    
    public init(image: Data?, description: String?) {
        self.image = image
        self.description = description
    }
}
