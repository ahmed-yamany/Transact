//
//  OnboardingEntity.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import UIKit

public struct OnboardingEntity: Identifiable {
    public var id = UUID()
    
    public let image: UIImage
    public let description: String
    
    public init(id: UUID = UUID(), image: UIImage, description: String) {
        self.id = id
        self.image = image
        self.description = description
    }
}
