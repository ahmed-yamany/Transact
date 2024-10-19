//
//  OnboardingEntityMapper.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import UIKit

internal extension OnboardingEntity {
    init(model: OnboardingModel) {
        image = UIImage(data: model.image ?? Data()) ?? UIImage()
        description = model.description ?? ""
    }
}
