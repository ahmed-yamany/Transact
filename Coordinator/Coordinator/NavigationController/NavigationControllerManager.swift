//
//  NavigationControllerManager.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 28/12/2024.
//

import UIKit

/// A class that manages navigation actions for a `UINavigationController`.
@MainActor
public class NavigationControllerManager {
    /// The underlying `UINavigationController` instance.
    public let navigationController: UINavigationController

    /// Initializes a new instance of `NavigationRouter`.
    /// - Parameter navigationController: The `UINavigationController` to be managed by this router.
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }


    /// Sets the visibility of the back button for the visible view controller.
    /// - Parameters:
    ///   - hidesBackButton: A boolean indicating whether the back button should be hidden.
    ///   - animated: A boolean indicating whether the transition is animated.
    public func setHidesVisibleViewControllerBackButton(_ hidesBackButton: Bool, animated: Bool) {
//        visibleViewController?.navigationItem.setHidesBackButton(hidesBackButton, animated: animated)
    }


    /// Sets the title for the back button of the visible view controller.
    /// - Parameter title: The title to set for the back button.
    public func setVisibleViewControllerBackButtonTitle(_ title: String) {
//        visibleViewController?.navigationItem.backButtonTitle = title
    }
}
