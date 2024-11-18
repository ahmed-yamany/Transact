//
//  OnboardingModelTests.swift
//  OnboardingTests
//
//  Created by Ahmed Yamany on 16/11/2024.
//

@testable import Onboarding
import Testing
import UIKit

struct OnboardingModelTests {
    @Test("OnboardingModel Intializer", .tags(.initializer), arguments: [
        (nil, nil),
        (Data(), "decription"),
        (UIImage(systemName: "house")?.pngData(), "decription2"),
    ])
    func initializer(_ image: Data?, _ description: String?) throws {
        let sut = OnboardingModel(image: image, description: description)
        #expect(sut.image == image)
        #expect(sut.description == description)
    }
}
