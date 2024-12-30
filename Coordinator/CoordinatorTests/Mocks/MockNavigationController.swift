//
//  MockNavigationController.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 30/12/2024.
//
import UIKit

class MockNavigationController: UINavigationController {
    var isPushAnimated: Bool = false
    var isSetViewControllersAnimated: Bool = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        isPushAnimated = animated
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        isSetViewControllersAnimated = animated
    }
}
