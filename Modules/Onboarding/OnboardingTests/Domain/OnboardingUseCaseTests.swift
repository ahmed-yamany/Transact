//
//  OnboardingUseCaseTests.swift
//  OnboardingTests
//
//  Created by Ahmed Yamany on 16/11/2024.
//

@testable import Onboarding
import Testing
import UIKit

struct OnboardingUseCaseTests {
    init() async throws {
    }

    func sut(_ service: OnboardingServiceInterface) -> OnboardingUseCase {
        OnboardingUseCase(service: service)
    }

    @Test("initializer", .tags(.initializer))
    func initializer() async throws {
        let spyService = OnboardingServiceEmptySpy()
        let sut = sut(spyService)

        _ = try await #require(sut.service as? OnboardingServiceEmptySpy, "Use Case Service must be of the type given to the initializer")
    }

    @Test
    func getOnboardingModels_whenServiceReturnsEmptyArray_shouldReturnsEmptyArray() async throws {
        let spyService = OnboardingServiceEmptySpy()
        let sut = sut(spyService)

        let result = try await sut.getOnboardingModels()

        #expect(result.isEmpty, "getOnboardingModels must return an empty array when the service returns an empty array")
    }

    @Test
    func getOnboardingModels_callService_toGetOnboardingModels() async throws {
        let spyService = OnboardingServiceEmptySpy()
        let sut = sut(spyService)

        _ = try await sut.getOnboardingModels()

        #expect(spyService.getOnboardingModelsCalled, "getOnboardingModels must call the service to get onboarding models")
    }

    @Test
    func getOnboardingModels_correctllyMappingToOnboardingEntity() async throws {
        let firstModel = OnboardingModel(image: nil, description: "d1")
        let lastModel = OnboardingModel(image: Data(), description: "d2")
        let stubService = OnboardingServiceStub(models: [firstModel, lastModel])
        let sut = sut(stubService)

        let entities = try await sut.getOnboardingModels()
        
        let first = try #require(entities.first)
        let last = try #require(entities.last)
        
        if firstModel.description == nil {
            #expect(first.description.isEmpty)
        } else {
            #expect(first.description == firstModel.description)
        }
        
        if lastModel.description == nil {
            #expect(last.description.isEmpty)
        } else {
            #expect(last.description == lastModel.description)
        }
        
        #expect(firstModel.image?.count == first.image.pngData()?.count)
    }
}

private class OnboardingServiceEmptySpy: OnboardingServiceInterface {
    var getOnboardingModelsCalled: Bool = false

    func getOnboardingModels() async throws -> [OnboardingModel] {
        getOnboardingModelsCalled = true
        return []
    }
}

private struct OnboardingServiceStub: OnboardingServiceInterface {
    let models: [OnboardingModel]

    func getOnboardingModels() async throws -> [OnboardingModel] {
        return models
    }
}
