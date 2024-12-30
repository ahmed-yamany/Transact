//
//  NavigationControllerManagerTests.swift
//  CoordinatorTests
//
//  Created by Ahmed Yamany on 28/12/2024.
//

@testable import Coordinator
import Testing
import UIKit

@MainActor
@Suite("Navigaition Controller Manager")
struct NavigationControllerManagerTests {
    func makeSut(_ navigationController: UINavigationController = UINavigationController()) -> NavigationControllerManager {
        .init(navigationController: navigationController)
    }

    @Test("initializer")
    func test_initializer() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerManager(navigationController: navigationController)
        #expect(sut.navigationController === navigationController)
    }

    @Test("properties")
    func test_properties() {
        let sut = makeSut()
        #expect(sut.navigationController.navigationBar === sut.navigationBar)
        #expect(sut.navigationController.viewControllers == sut.viewControllers)
        #expect(sut.navigationController.topViewController === sut.topViewController)
        #expect(sut.navigationController.visibleViewController === sut.visibleViewController)
    }

    @Test("viewControllersOfType")
    func test_ViewControllersOfType() {
        // Create instances of different view controller types
        let viewController1 = UIViewController()
        let viewController2 = UITableViewController()
        let viewController3 = UIViewController()
        let viewController4 = UITableViewController()

        let sut = makeSut()
        sut.setViewControllers([viewController1, viewController2, viewController3, viewController4])

        // Test fetching UIViewControllers
        let uiViewControllers = sut.viewControllers(ofType: UIViewController.self)
        #expect(uiViewControllers.count == 4)
        #expect(uiViewControllers.contains(viewController1))
        #expect(uiViewControllers.contains(viewController3))

        // Test fetching UITableViewControllers
        let tableViewControllers = sut.viewControllers(ofType: UITableViewController.self)
        #expect(tableViewControllers.count == 2)
        #expect(tableViewControllers.contains(viewController2))
        #expect(tableViewControllers.contains(viewController4))

        // Test fetching a type that isn't present
        let collectionViewControllers = sut.viewControllers(ofType: UICollectionViewController.self)
        #expect(collectionViewControllers.isEmpty)
    }

    @Test("containsViewController")
    func test_ContainsViewController() {
        // Create instances of UIViewController
        let viewController1 = UIViewController()
        let viewController2 = UITableViewController()
        let viewController3 = UIViewController()

        let sut = makeSut()

        // Set the navigation controller's stack
        sut.setViewControllers([viewController1, viewController2], animated: false)

        // Test case: Check if the stack contains a view controller that is present
        #expect(sut.containsViewController(viewController1))
        #expect(sut.containsViewController(viewController2))

        // Test case: Check if the stack contains a view controller that is not present
        #expect(!sut.containsViewController(viewController3))
    }

    @Test("push")
    func test_push() async {
        let mockNC = MockNavigationController()
        let sut = makeSut(mockNC)
        _ = mockNC.view
        let viewController1 = UIViewController()
        let viewController2 = UIViewController()

        sut.push(viewController1, animated: true)
        #expect(sut.viewControllers.last === viewController1, "The view controller should be the last one in the stack.")
        #expect(mockNC.isPushAnimated, "The push should have been animated.")

        sut.push(viewController2, animated: false)
        #expect(sut.viewControllers.last === viewController2, "The view controller should be the last one in the stack.")
        #expect(!mockNC.isPushAnimated, "The push should not have been animated.")
    }

    @Test("pushContentsOfViewControllers")
    func testPushContentsOfViewControllers() {
        let sut = makeSut()

        let initialViewController = UIViewController()
        sut.setViewControllers([initialViewController], animated: false, completion: {})

        let newViewController1 = UIViewController()
        let newViewController2 = UIViewController()
        let viewControllersToAppend = [newViewController1, newViewController2]

        sut.push(contentsOf: viewControllersToAppend, animated: false)
        let expectedVCs = [initialViewController, newViewController1, newViewController2]
        #expect(sut.viewControllers == expectedVCs, "The new view controllers should be appended to the existing stack.")
    }

    @Test("setViewControllers")
    func testSetViewControllers() {
        let sut = makeSut()
        let viewController1 = UIViewController()
        let viewController2 = UIViewController()
        let viewControllersToSet = [viewController1, viewController2]

        sut.setViewControllers(viewControllersToSet, animated: true)
        #expect(sut.viewControllers == viewControllersToSet, "The navigation controller's stack should match the provided view controllers.")

        let viewController3 = UIViewController()
        sut.setViewControllers([viewController3], animated: false)

        #expect(sut.viewControllers == [viewController3], "The navigation controller's stack should be replaced by the new set of view controllers.")
    }

    @Test("setViewController")
    func testSetViewController() {
        let sut = makeSut()

        let viewController = UIViewController()
        sut.setViewController(viewController)
        #expect(sut.viewControllers == [viewController], "The navigation controller's stack should contain the single view controller.")

        let viewController2 = UITabBarController()
        sut.setViewController(viewController2, animated: false)
        #expect(sut.viewControllers.first === viewController2, "The navigation controller's stack should contain the single view controller.")
    }

//    @Test("repacingLastViewController")
//    func testReplaceLastViewController() async {
//        let sut = makeSut()
//        let firstViewController = UIViewController()
//        let secondViewController = UIViewController()
//        sut.setViewControllers([firstViewController, secondViewController], animated: false)
//
//        let viewControllerToReplaceWith = UIViewController()
//        _ = viewControllerToReplaceWith.view
//        print(sut.viewControllers)
////        sut.setViewControllers([firstViewController, viewControllerToReplaceWith], animated: false)
//
//        sut.replaceLastViewController(with: viewControllerToReplaceWith, animated: false)
//        print(sut.viewControllers)
//        #expect(sut.viewControllers.count == 2, "The navigation controller should still have two view controllers.")
//        #expect(sut.viewControllers.first == firstViewController)
//        try? await Task.sleep(for: .seconds(2))
//        #expect(sut.navigationController.viewControllers.last === viewControllerToReplaceWith, "The last view controller should have been replaced.")
//    }
//    
//    @Test
//    func test_replaceFirstViewController() async {
//        
//        let sut = makeSut()
//        let firstViewController = UIViewController()
//        let secondViewController = UIViewController()
//        sut.setViewControllers([firstViewController, secondViewController], animated: false)
//
//        let viewControllerToReplaceWith = UIViewController()
//
//        sut.replaceFirstViewController(with: viewControllerToReplaceWith, animated: false)
////
//        #expect(sut.navigationController.viewControllers.first === viewControllerToReplaceWith, "The last view controller should have been replaced.")
//    }
}


