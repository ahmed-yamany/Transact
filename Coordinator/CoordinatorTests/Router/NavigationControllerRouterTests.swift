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
        let sut = NavigationControllerRouter(navigationController: navigationController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut.navigationController
        return sut
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

    func test_ReplaceViewAtIndex_WhenGivenValidIndex() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView2())
        let v3 = AnyHashableView(MockView3())

        sut.setViews([v1, v2], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.replaceView(at: 1, with: v3, animated: false) {
            expectation.fulfill()
        }

        XCTAssertEqual(sut.navigationController.viewControllers.count, 2, "Navigation controller should still have 2 view controllers.")
        let viewController = sut.hashableViewControllers
        XCTAssertTrue(viewController[1].type == v3.type, "The view at index 1 should be replaced with the new view.")

        wait(for: [expectation], timeout: 1.0)
    }

    func test_ReplaceFirstView() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView2())
        let v3 = AnyHashableView(MockView3())

        sut.setViews([v1, v2], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.replaceFirstView(with: v3, animated: false, completion: {
            expectation.fulfill()
        })

        XCTAssertEqual(sut.navigationController.viewControllers.count, 2, "Navigation controller should still have 2 view controllers.")
        let viewController = sut.hashableViewControllers
        XCTAssertTrue(viewController.first?.type == v3.type, "The view at the first index should be replaced with the new view.")

        wait(for: [expectation], timeout: 1.0)
    }

    func test_ReplaceLastView() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView2())
        let v3 = AnyHashableView(MockView3())

        sut.setViews([v1, v2], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.replaceLastView(with: v3, animated: false, completion: {
            expectation.fulfill()
        })

        XCTAssertEqual(sut.navigationController.viewControllers.count, 2, "Navigation controller should still have 2 view controllers.")
        let viewController = sut.hashableViewControllers
        XCTAssertTrue(viewController.last?.type == v3.type, "The view at the last index should be replaced with the new view.")

        wait(for: [expectation], timeout: 1.0)
    }

    func test_insertContentsOfViewsAtIndex() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView2())
        let v4 = AnyHashableView(MockView3())

        sut.setViews([v1, v2], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.insert(contentsOfViews: [v3, v4], at: 1, animated: false, completion: {
            expectation.fulfill()
        })

        XCTAssertEqual(sut.navigationController.viewControllers.count, 4, "Navigation controller should still have 2 view controllers.")
        let viewController = sut.hashableViewControllers
        XCTAssertTrue(viewController.last?.type == v2.type, "The view at index 1 should be of type MockView2.")
        XCTAssertTrue(viewController.first?.type == v1.type, "The view at first index should be of type MockView1.")
        XCTAssertTrue(viewController[1].type == v3.type, "The view at index 1 should be of type MockView3.")
        XCTAssertTrue(viewController[2].type == v4.type, "The view at index 1 should be of type MockView4.")

        wait(for: [expectation], timeout: 1.0)
    }

    func test_insertViewAtIndex() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView2())

        sut.setViews([v1, v2], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.insert(v3, at: 1, animated: false, completion: {
            expectation.fulfill()
        })

        XCTAssertEqual(sut.navigationController.viewControllers.count, 3, "Navigation controller should still have 2 view controllers.")
        let viewController = sut.hashableViewControllers
        XCTAssertTrue(viewController.last?.type == v2.type, "The view at index 1 should be of type MockView2.")
        XCTAssertTrue(viewController.first?.type == v1.type, "The view at first index should be of type MockView1.")
        XCTAssertTrue(viewController[1].type == v3.type, "The view at index 1 should be of type MockView3.")

        wait(for: [expectation], timeout: 1.0)
    }

    func test_pop() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView2())

        sut.setViews([v1, v2, v3], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.pop(animated: false, completion: {
            expectation.fulfill()
        })

        XCTAssertEqual(sut.navigationController.viewControllers.count, 2, "Navigation controller should still have 2 view controllers.")
        let viewController = sut.hashableViewControllers
        XCTAssertTrue(viewController.first?.type == v1.type)
        XCTAssertTrue(viewController.last?.type == v2.type)

        sut.pop(animated: false, completion: nil)
        XCTAssertTrue(viewController.first?.type == v1.type)
        XCTAssertTrue(viewController.last?.type == v1.type)
        wait(for: [expectation], timeout: 1.0)
    }

    func test_popToRoot() {
        let nvc = MockNavigationController()
        let sut = makeSut(nvc)

        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView2())

        sut.setViews([v1, v2, v3], animated: false, completion: nil)

        let expectation = expectation(description: "Completion handler called")
        sut.popToRoot(animated: false, completion: {
            expectation.fulfill()
        })

        XCTAssertEqual(sut.navigationController.viewControllers.count, 1, "Navigation controller should  have 1 view controllers.")
        let viewController = sut.hashableViewControllers

        XCTAssertTrue(viewController.first?.type == v1.type)
        XCTAssertTrue(viewController.last?.type == v1.type)
        wait(for: [expectation], timeout: 1.0)
    }

    func test_Present() {
        let sut = makeSut()

        sut.setView(AnyHashableView(Text("")), animated: false, completion: nil)
        let view = AnyHashableView(MockView1())

        _ = sut.navigationController.view
        _ = sut.navigationController.topViewController?.view
        _ = sut.navigationController.visibleViewController?.view

        sut.present(
            view,
            animated: false,
            presentationStyle: .fullScreen,
            transitionStyle: .crossDissolve,
            completion: nil
        )

        guard let presentedViewController = sut.navigationController.visibleViewController as? UIHashableHostingController else {
            XCTFail("No view controller was presented.")
            return
        }

        XCTAssertTrue(presentedViewController.rootView == view, "The presented view controller's root view should match the provided view.")
        XCTAssertEqual(
            presentedViewController.modalPresentationStyle,
            .fullScreen,
            "The presented view controller should have a full-screen presentation style."
        )
        XCTAssertEqual(
            presentedViewController.modalTransitionStyle,
            .crossDissolve,
            "The presented view controller should have a cross dissolve transition style."
        )
    }

    func test_dismiss() async {
        let sut = makeSut()
        let view = AnyHashableView(MockView1())

        sut.present(
            view,
            animated: false,
            presentationStyle: .fullScreen,
            transitionStyle: .crossDissolve,
            completion: nil
        )
        XCTAssertEqual((sut.presentedViewController as? UIHashableHostingController)?.rootView, view)
        sut.dismiss(animated: false, completion: nil)
        try? await Task.sleep(for: .seconds(1))
        XCTAssertEqual(sut.presentedViewController, sut.navigationController)
    }

    // MARK: - Pop to View Tests

    func testPopToViewWithMatchingType() {
        let sut = makeSut()

        let view1 = AnyHashableView(MockView1())
        let view2 = AnyHashableView(MockView2())
        let view3 = AnyHashableView(MockView3())
        sut.setViews([view1, view2, view3], animated: false, completion: nil)
        _ = sut.navigationController.view
        _ = sut.navigationController.topViewController?.view
        _ = sut.navigationController.visibleViewController?.view
        XCTAssertEqual(sut.navigationController.viewControllers.count, 3, "Navigation stack should have three views.")
        let expectation = expectation(description: "Pop to view completion called")

        sut.popToView(withType: MockView1.self, animated: false) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        let viewControllers = sut.hashableViewControllers
        XCTAssertEqual(viewControllers.count, 1, "Navigation stack should have popped to the matching view.")
        XCTAssertTrue(viewControllers.last?.rootView == view1, "The last view controller should match the target view.")
    }
}

extension NavigationControllerRouter {
    var hashableViewControllers: [UIHashableHostingController] {
        navigationController.viewControllers.compactMap { $0 as? UIHashableHostingController }
    }
}
