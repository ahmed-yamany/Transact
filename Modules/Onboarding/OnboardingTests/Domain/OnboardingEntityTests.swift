//
//  OnboardingEntityTests.swift
//  OnboardingTests
//
//  Created by Ahmed Yamany on 16/11/2024.
//

@testable import Onboarding
import Testing
import UIKit

struct OnboardingEntityTests {
    @Test("OnboardingEntity Initializer", .tags(.initializer), arguments: [
        (UIImage(), ""),
        (UIImage(), "Description"),
    ])
    func initializer(_ image: UIImage?, description: String) throws {
        let image = try #require(image)
        let sut = OnboardingEntity(image: image, description: description)
        #expect(sut.image == image, "Entity image must be equal to the image provided to The initializer.")
        #expect(sut.description == description, "Entity description must be equal to the description provided to The initializer.")
    }
}
