//
//  OnboardingEntityMapperTests.swift
//  OnboardingTests
//
//  Created by Ahmed Yamany on 16/11/2024.
//

@testable import Onboarding
import Testing
import UIKit

struct OnboardingEntityMapperTests {
    @Test(arguments: [
        nil,
        "test description",
    ])
    func description_when_initializer_takes_OnboardingModel(_ description: String?) async throws {
        let model = OnboardingModel(image: nil, description: description)
        let sut = OnboardingEntity(model: model)
        if description == nil {
            #expect(sut.description.isEmpty, "OnboardingEntity description should be empty when initializer takes nil")
        } else {
            #expect(sut.description == description, "OnboardingEntity description should be the description provided by the model")
        }
    }

    @Test(arguments: [
        nil,
        UIImage(systemName: "house")?.pngData(),
    ])
    func image_when_initializer_takes_OnboardingModel(_ image: Data?) async throws {
        let model = OnboardingModel(image: image, description: nil)
        let sut = OnboardingEntity(model: model)
        if image == nil {
            #expect(sut.image == UIImage(), "OnboardingEntity image should be nil when initializer takes nil")
        } else {
            #expect(sut.image.pngData()?.count == image?.count, "OnboardingEntity image should be the image provided by the model")
        }
    }
}
