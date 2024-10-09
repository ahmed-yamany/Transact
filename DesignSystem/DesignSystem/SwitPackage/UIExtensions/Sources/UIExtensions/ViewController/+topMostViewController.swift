//
//  +topMostViewController.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UIViewController {
    /// Returns the topmost view controller in the view controller hierarchy.
    ///
    /// This method traverses through the view controller hierarchy starting from the
    /// receiver (self) to find the topmost view controller that is currently visible
    /// or presented modally.
    ///
    /// - Returns: The topmost UIViewController in the view controller hierarchy,
    ///            or nil if no view controller is found.
    func topMostViewController() -> UIViewController? {
        if self.presentedViewController == nil {
            return self
        }

        if let navigation = self.presentedViewController as? UINavigationController,
           let visibleViewController = navigation.visibleViewController {
            return visibleViewController.topMostViewController()
        }

        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            // If no selected view controller is available, check the tab bar controller itself.
            return tab.topMostViewController()
        }
        
        // If none of the above conditions are met,
        // return nil indicating that the presentedViewController is not found.
        guard let presentedViewController = self.presentedViewController else {
            return nil
        }
        
        // If none of the conditions above match, continue the search in the presented view controller.
        return presentedViewController.topMostViewController()
    }
}
#endif
