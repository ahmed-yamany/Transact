//
//  OnboardingService.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Onboarding
import UIKit

struct OnboardingResourceModel: Decodable {
    let image: String
    let description: String
}

class OnboardingService: OnboardingServiceInterface {
    func getOnboardingModels() async throws -> [OnboardingModel] {
        guard let url = Bundle.main.url(forResource: "onboarding", withExtension: "json") else {
            return []
        }

        let data = try Data(contentsOf: url)

        let models: [OnboardingResourceModel] = try JSONDecoder().decode([OnboardingResourceModel].self, from: data)

        return models.map {
            OnboardingModel(image: UIImage(named: $0.image)?.pngData() ?? Data(), description: $0.description)
        }
    }
}
