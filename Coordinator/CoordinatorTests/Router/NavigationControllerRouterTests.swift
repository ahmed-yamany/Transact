//
//  NavigationControllerRouterTests.swift
//  CoordinatorTests
//
//  Created by Ahmed Yamany on 30/12/2024.
//

@testable import Coordinator
import SwiftUI
import XCTest

@MainActor
final class NavigationControllerRouterTests: XCTestCase {
    func makeSut(_ navigationController: UINavigationController = UINavigationController()) -> NavigationControllerRouter {
        NavigationControllerRouter(navigationController: navigationController)
    }

    func test_initializer() {
        let navigationController = UINavigationController()
        let sut = makeSut(navigationController)
        XCTAssertEqual(navigationController, sut.navigationController, "router navigation controller must be the same as injected navigation controller")
    }

    func test_pushOneView_viewControllersCountShouldOne() {
        let sut = makeSut()
        let v1 = AnyHashableView(MockView1())
        sut.push(v1, animated: false, completion: nil)
        let viewControllers = sut.hashableViewControllers
        XCTAssertTrue(viewControllers.count == 1, "view controllers count must be same as pushed count")
        XCTAssertTrue(viewControllers.first?.type == MockView1.self, "pushed view controller type must be same as pushed view")
    }

    func test_push_completionHandler() {
        let sut = makeSut()
        let v1 = AnyHashableView(MockView1())

        let expectation = XCTestExpectation()
        sut.push(v1, animated: false, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_push_animation() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)
        let v1 = AnyHashableView(MockView1())

        sut.push(v1, animated: true, completion: nil)

        XCTAssertTrue(nvc.isPushAnimated)
    }

    func test_setViews_viewControllersTypeShouldBeTheSameToSetedViews() {
        let sut = makeSut()
        sut.navigationController.viewControllers = [UIViewController(), UIViewController()]

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView2())
        let v3 = AnyHashableView(MockView3())

        sut.setViews([v1, v2, v3], animated: false, completion: nil)

        XCTAssertTrue(sut.hashableViewControllers.count == 3)
        let viewControllers = sut.hashableViewControllers
        XCTAssertTrue(viewControllers[0].type == v1.type)
        XCTAssertTrue(viewControllers[1].type == v2.type)
        XCTAssertTrue(viewControllers[2].type == v3.type)
    }

    func test_setViews_completionHandeler() {
        let sut = makeSut()
        let expectation = XCTestExpectation()
        sut.setViews([AnyHashableView(MockView1())], animated: false, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }

    func test_setViews_animation() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        sut.setViews([AnyHashableView(MockView1())], animated: true, completion: nil)
        XCTAssertTrue(nvc.isSetViewControllersAnimated)
    }

    func test_setView_shouldReplaceAllViewsWithTheGivenView() {
        let sut = makeSut()
        sut.navigationController.viewControllers = [UIViewController(), UIViewController()]

        let v1 = AnyHashableView(MockView1())

        sut.setView(v1, animated: false, completion: nil)

        XCTAssertTrue(sut.hashableViewControllers.count == 1)
        let viewControllers = sut.hashableViewControllers
        XCTAssertTrue(viewControllers[0].type == v1.type)
    }

    func testPushContentsOfViews() {
        let sut = makeSut()

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView2())
        let v3 = AnyHashableView(MockView3())

        let initialViewController = UIHashableHostingController(rootView: v1)
        sut.navigationController.viewControllers = [initialViewController]

        let expectation = expectation(description: "Completion handler called")
        sut.push(contentsOf: [v2, v3], animated: false) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(sut.navigationController.viewControllers.count, 3, "Navigation controller should have 3 view controllers after appending.")

        let viewControllers = sut.hashableViewControllers
        XCTAssertTrue(viewControllers[1].type == v2.type, "First appended view should match v1.")
        XCTAssertTrue(viewControllers[2].type == v3.type, "Second appended view should match v2.")

    }
}

extension NavigationControllerRouter {
    var hashableViewControllers: [UIHashableHostingController] {
        navigationController.viewControllers.compactMap { $0 as? UIHashableHostingController }
    }
}
