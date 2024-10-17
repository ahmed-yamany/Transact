//
//  NavigationStackRouterTests.swift
//  CoordinatorTests
//
//  Created by Ahmed Yamany on 14/10/2024.
//

@testable import Coordinator
import SwiftUI
import XCTest

final class NavigationStackRouterTests: XCTestCase {
    var sut: NavigationStackRouter!

    @MainActor
    override func setUp() {
        sut = NavigationStackRouter()
    }

    override func tearDown() {
        sut = nil
    }

    @MainActor
    func test_push_WhenPushOneView_RootViewShouldNotBeNilAndStackEmpty() {
        XCTAssertNil(sut.rootView)
        sut.push(Text(""), animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "NavigationStackRouter RootView is Nil When Pushing One View")
        XCTAssertTrue(sut.navigationStack.isEmpty, "NavigationStackRouter Stack is Not Empty When Pushing One View")
    }

    @MainActor
    func test_push_WhenPushingTwoView_StackCountShouldBeOneAndRootViewNotNil() {
        sut.push(Text(""), animated: true, completion: nil)
        sut.push(Text(""), animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "Root view should be set")
        XCTAssertFalse(sut.navigationStack.isEmpty, "NavigationStackRouter Stack is Empty When Pushing More Than One View")
        XCTAssertEqual(sut.navigationStack.count, 1, "NavigationStackRouter Stack Count is not 1 when pushing two views")
    }

    @MainActor
    func test_push_WhenPushingWithAnimation_TransitionShouldEnableAnimation() {
        sut.push(Text(""), animated: true, completion: nil)
        XCTAssertFalse(sut.transaction.disablesAnimations, "Transiotion Should Enable Animation when animated is true")
    }

    @MainActor
    func test_push_WhenPushingWithoutAnimation_TransitionShouldDisableAnimation() {
        sut.push(Text(""), animated: false, completion: nil)
        XCTAssertTrue(sut.transaction.disablesAnimations, "Transiotion Should Disable Animation when animated is false")
    }

    @MainActor
    func test_setView_SetSingleViewAsRoot_StackShouldBeEmptyAndRootViewNotNil() {
        let view = Text("")
        sut.setView(view, animated: false, completion: nil)

        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting single view")
        XCTAssertTrue(sut.navigationStack.isEmpty, "navigationStack must be empty when setting single view")
    }

    @MainActor
    func test_setView_SetViewMultibleTimes_StackShouldBeEmptyAndRootViewNotNil() {
        sut.setView(Text(""), animated: false, completion: nil)
        sut.setView(Text(""), animated: false, completion: nil)
        sut.setView(Text(""), animated: false, completion: nil)

        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting multiple views")
        XCTAssertTrue(sut.navigationStack.isEmpty, "navigationStack must be empty when setting multiple views")
    }

    @MainActor
    func test_setView_SetView_shouldReplaceRootView() {
        let firstView = Text("First View")
        let secondView = Text("Second View")

        sut.setView(firstView, animated: false, completion: nil)
        sut.setView(secondView, animated: false, completion: nil)

        XCTAssertTrue(sut.navigationStack.isEmpty, "Stack should remain empty when using setView")
    }

    @MainActor
    func test_setViews_WhenSettingEmptyViews_RootViewShouldBeNil() {
        let views: [AnyView] = []
        sut.setViews(views, animated: true, completion: nil)
        XCTAssertNil(sut.rootView, "rootView should be nil when settings empty array")
    }

    @MainActor
    func test_setViews_WhenSettingOneView_RootViewShouldNotBeNilAndStackShouldBeNil() {
        sut.setViews([Text(""), Text(""), Text("")], animated: true, completion: nil)
        sut.setViews([Text("")], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting one view")
        XCTAssertTrue(sut.navigationStack.isEmpty, "stack must be empty when settings one view")
    }

    @MainActor
    func test_setViews_WhenSettingTwoViews_StackCountShouldBeOne() {
        sut.setViews([Text(""), Text("")], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting two views")
        XCTAssertEqual(sut.navigationStack.count, 1, "stack count must be one when setting two views")
    }

    @MainActor
    func test_setViews_WhenSettingTwoViews_StackCountShouldBeOne_1() {
        sut.setViews([Text(""), Text(""), Text(""), Text("")], animated: true, completion: nil)
        sut.setViews([Text(""), Text("")], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting two views")
        XCTAssertEqual(sut.navigationStack.count, 1, "stack count must be one when setting two views")
    }

    @MainActor
    func test_setViews_WhenReSettingViews_RootViewShouldBeNilAndStackEmpty() {
        sut.setViews([Text(""), Text("")], animated: true, completion: nil)
        let views: [AnyView] = []
        sut.setViews(views, animated: true, completion: nil)
        XCTAssertNil(sut.rootView, "rootView should be nil when reseting views")
        XCTAssertTrue(sut.navigationStack.isEmpty, "stack should be empty when reseting views")
    }

    @MainActor
    func test_pop_WhenSettingTwoViews_StackShouldBeEmpty() {
        let views = [
            Text("First View"),
            Text("Second View"),
        ]

        sut.setViews(views, animated: false, completion: nil)
        sut.pop(animated: false, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when pushing two views and poping one view ")
        XCTAssertTrue(sut.navigationStack.isEmpty, "navigationStack should be empty when pushing two views and poping one view")
    }

    @MainActor
    func test_pop_WhenSettingThreeViews_StackShouldBeOne() {
        let views = [
            Text("First View"),
            Text("Second View"),
            Text("Second View"),
        ]

        sut.setViews(views, animated: false, completion: nil)
        sut.pop(animated: false, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when pushing three views and poping one view ")
        XCTAssertEqual(sut.navigationStack.count, 1, "navigationStack count should be 1 when pushing three views and poping one view")
    }

    @MainActor
    func test_PopToRoot() {
        let views = [
            Text("First View"),
            Text("Second View"),
        ]
        sut.setViews(views, animated: false, completion: nil)

        sut.popToRoot(animated: false, completion: nil)
        XCTAssertNotNil(sut.rootView)
        XCTAssertTrue(sut.navigationStack.isEmpty)
    }

    @MainActor
    func test_PresentFullScreenCover() {
        let view = Text("FullScreenCover View")
        sut.present(view, animated: false, presentationStyle: .fullScreen, transitionStyle: .coverVertical, completion: nil)

        XCTAssertNotNil(sut.fullScreenCoverView)
        XCTAssertNil(sut.sheetView)
    }

    @MainActor
    func test_PresentSheetView() {
        let view = Text("Sheet View")
        sut.present(view, animated: false, presentationStyle: .pageSheet, transitionStyle: .coverVertical, completion: nil)

        XCTAssertNotNil(sut.sheetView)
        XCTAssertNil(sut.fullScreenCoverView)
    }
}
