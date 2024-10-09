//
//  OnboardingViewModel.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI
import Combine

@MainActor
public protocol OnboardingViewModelInterface: ObservableObject {
    var currentTabViewIndex: Int { get set }
    var tabViewModels: [String] { get set }
    var enableBackButton: Bool { get set }
    
    func skipButtonTapped()
    func backButtonTapped()
    func nextButtonTapped()
}

@MainActor
final public class OnboardingViewModel: OnboardingViewModelInterface {
    @Published public var currentTabViewIndex: Int = 0
    @Published public var tabViewModels: [String] = []
    @Published public var enableBackButton: Bool = false
  
    let coordinator: OnboardingCoordinatorInterface
    
    public init(coordinator: OnboardingCoordinatorInterface) {
        self.coordinator = coordinator
    }
    
    public func skipButtonTapped() {
        
    }
    
    public func backButtonTapped() {
        
    }
    
    public func nextButtonTapped() {
        
    }
}
