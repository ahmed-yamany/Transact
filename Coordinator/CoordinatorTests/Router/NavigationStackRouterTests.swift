//
//  NavigationStackRouterTests.swift
//  CoordinatorTests
//
//  Created by Ahmed Yamany on 14/10/2024.
//

@testable import Coordinator
import SwiftUI
import XCTest

@MainActor
final class NavigationStackRouterTests: XCTestCase {
    var sut: NavigationStackRouter!

    @MainActor
    override func setUp() {
        sut = NavigationStackRouter()
    }

    override func tearDown() {
        sut = nil
    }

    func test_push_WhenPushOneView_RootViewShouldNotBeNilAndStackEmpty() {
        XCTAssertNil(sut.rootView)
        sut.push(AnyHashableView(Text("")), animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "NavigationStackRouter RootView is Nil When Pushing One View")
        XCTAssertTrue(sut.navigationStack.isEmpty, "NavigationStackRouter Stack is Not Empty When Pushing One View")
    }

    func test_push_WhenPushingTwoView_StackCountShouldBeOneAndRootViewNotNil() {
        sut.push(AnyHashableView(Text("")), animated: true, completion: nil)
        sut.push(AnyHashableView(Text("")), animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "Root view should be set")
        XCTAssertFalse(sut.navigationStack.isEmpty, "NavigationStackRouter Stack is Empty When Pushing More Than One View")
        XCTAssertEqual(sut.navigationStack.count, 1, "NavigationStackRouter Stack Count is not 1 when pushing two views")
    }

    func test_push_WhenPushingWithAnimation_TransitionShouldEnableAnimation() {
        sut.push(AnyHashableView(Text("")), animated: true, completion: nil)
        XCTAssertFalse(sut.transaction.disablesAnimations, "Transiotion Should Enable Animation when animated is true")
    }

    func test_push_WhenPushingWithoutAnimation_TransitionShouldDisableAnimation() {
        sut.push(AnyHashableView(Text("")), animated: false, completion: nil)
        XCTAssertTrue(sut.transaction.disablesAnimations, "Transiotion Should Disable Animation when animated is false")
    }

    func test_push_compoletion() {
        let expectation = XCTestExpectation()

        sut.push(AnyHashableView(Text("")), animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_setView_SetSingleViewAsRoot_StackShouldBeEmptyAndRootViewNotNil() {
        let view = AnyHashableView(Text(""))
        sut.setView(view, animated: false, completion: nil)

        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting single view")
        XCTAssertTrue(sut.navigationStack.isEmpty, "navigationStack must be empty when setting single view")
    }

    func test_setView_SetViewMultibleTimes_StackShouldBeEmptyAndRootViewNotNil() {
        sut.setView(AnyHashableView(Text("")), animated: false, completion: nil)
        sut.setView(AnyHashableView(Text("")), animated: false, completion: nil)
        sut.setView(AnyHashableView(Text("")), animated: false, completion: nil)

        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting multiple views")
        XCTAssertTrue(sut.navigationStack.isEmpty, "navigationStack must be empty when setting multiple views")
    }

    func test_setView_SetView_shouldReplaceRootView() {
        let firstView = AnyHashableView(Text("First View"))
        let secondView = AnyHashableView(Text("Second View"))

        sut.setView(firstView, animated: false, completion: nil)
        sut.setView(secondView, animated: false, completion: nil)

        XCTAssertTrue(sut.navigationStack.isEmpty, "Stack should be empty when using setView")
    }

    func test_setViews_WhenSettingEmptyViews_RootViewShouldBeNil() {
        let views: [AnyHashableView] = []
        sut.setViews(views, animated: true, completion: nil)
        XCTAssertNil(sut.rootView, "rootView should be nil when settings empty array")
    }

    func test_setViews_WhenSettingOneView_RootViewShouldNotBeNilAndStackShouldBeNil() {
        sut.setViews([Text(""), Text(""), Text("")].map { AnyHashableView($0) }, animated: true, completion: nil)
        sut.setViews([AnyHashableView(Text(""))], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting one view")
        XCTAssertTrue(sut.navigationStack.isEmpty, "stack must be empty when settings one view")
    }

    func test_setViews_WhenSettingTwoViews_StackCountShouldBeOne() {
        sut.setViews([Text(""), Text("")].map { AnyHashableView($0) }, animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting two views")
        XCTAssertEqual(sut.navigationStack.count, 1, "stack count must be one when setting two views")
    }

    func test_setViews_WhenSettingTwoViews_StackCountShouldBeOne_1() {
        sut.setViews([Text(""), Text(""), Text(""), Text("")].map { AnyHashableView($0) }, animated: true, completion: nil)
        sut.setViews([Text(""), Text("")].map { AnyHashableView($0) }, animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting two views")
        XCTAssertEqual(sut.navigationStack.count, 1, "stack count must be one when setting two views")
    }

    func test_setViews_WhenReSettingViews_RootViewShouldBeNilAndStackEmpty() {
        sut.setViews([Text(""), Text("")].map { AnyHashableView($0) }, animated: true, completion: nil)
        sut.setViews([], animated: true, completion: nil)
        XCTAssertNil(sut.rootView, "rootView should be nil when reseting views")
        XCTAssertTrue(sut.navigationStack.isEmpty, "stack should be empty when reseting views")
    }

    func test_setViews_completionShouldBeCalled() {
        let expectation = XCTestExpectation()

        sut.setViews([AnyHashableView(Text(""))], animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_pop_WhenSettingTwoViews_StackShouldBeEmpty() {
        let views = [
            Text("First View"),
            Text("Second View"),
        ].map { AnyHashableView($0) }

        sut.setViews(views, animated: false, completion: nil)
        sut.pop(animated: false, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when pushing two views and poping one view ")
        XCTAssertTrue(sut.navigationStack.isEmpty, "navigationStack should be empty when pushing two views and poping one view")
    }

    func test_pop_WhenSettingThreeViews_StackShouldBeOne() {
        let views = [
            Text("First View"),
            Text("Second View"),
            Text("Second View"),
        ].map { AnyHashableView($0) }

        sut.setViews(views, animated: false, completion: nil)
        sut.pop(animated: false, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when pushing three views and poping one view ")
        XCTAssertEqual(sut.navigationStack.count, 1, "navigationStack count should be 1 when pushing three views and poping one view")
    }

    func test_pop_completion() {
        let expectation = XCTestExpectation()

        sut.setViews([Text("First View"), Text("Second View")].map { AnyHashableView($0) }, animated: true, completion: nil)
        sut.pop(animated: true, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }

    func test_PopToRoot() {
        let views = [
            Text("First View"),
            Text("Second View"),
        ].map { AnyHashableView($0) }
        sut.setViews(views, animated: false, completion: nil)

        sut.popToRoot(animated: false, completion: nil)
        XCTAssertNotNil(sut.rootView)
        XCTAssertTrue(sut.navigationStack.isEmpty)
    }

    func test_popToRoot_completion() {
        let expectation = XCTestExpectation()

        sut.setViews([Text("First View"), Text("Second View")].map { AnyHashableView($0) }, animated: true, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }

    func test_PresentFullScreenCover() {
        let view = AnyHashableView(Text("FullScreenCover View"))
        sut.present(view, animated: false, presentationStyle: .fullScreen, transitionStyle: .coverVertical, completion: nil)

        XCTAssertNotNil(sut.fullScreenCoverView)
        XCTAssertNil(sut.sheetView)
    }

    func test_PresentSheetView() {
        let view = AnyHashableView(Text("Sheet View"))
        sut.present(view, animated: false, presentationStyle: .pageSheet, transitionStyle: .coverVertical, completion: nil)

        XCTAssertNotNil(sut.sheetView)
        XCTAssertNil(sut.fullScreenCoverView)
    }

    func test_present_completionShouldBeCalled() {
        let expectation = XCTestExpectation()

        sut.present(AnyHashableView(Text("")), animated: false, presentationStyle: .fullScreen, transitionStyle: .partialCurl, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_pushContentsOf_shouldPushNewViewsToStack() {
        let views = [Text("First"), Text("Second"), Text("Third")].map { AnyHashableView($0) }
        sut.setViews(views, animated: false, completion: nil)
        XCTAssertTrue(sut.navigationStack.count == 2)
        let viewsToPush = [Text("Fourth"), Text("Fifth"), Text("Sixth")].map { AnyHashableView($0) }
        sut.push(contentsOf: viewsToPush, animated: false, completion: nil)
        XCTAssertTrue(sut.navigationStack.count == 5)
    }

    func test_dismiss_shouldRemovePresentedViews() {
        sut.present(AnyHashableView(Text("")), animated: false, presentationStyle: .fullScreen, transitionStyle: .partialCurl, completion: nil)
        XCTAssertNotNil(sut.fullScreenCoverView)
        sut.dismiss(animated: false, completion: nil)
        XCTAssertNil(sut.fullScreenCoverView)
        XCTAssertNil(sut.sheetView)
    }

    func test_dismiss_completionShouldBeCalled() {
        let expectation = XCTestExpectation()

        sut.present(AnyHashableView(Text("")), animated: false, presentationStyle: .fullScreen, transitionStyle: .partialCurl, completion: nil)
        sut.dismiss(animated: true, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }

    func test_popToViewWithType_shouldPopToViewOfTheGivenType() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView2())
        let v3 = AnyHashableView(MockView3())
        let popToViewExpectation = XCTestExpectation()
        let popToRootExpectation = XCTestExpectation()

        sut.setViews([v1, v2, v3], animated: false, completion: nil)
        XCTAssertTrue(sut.navigationStack.count == 2)

        sut.popToView(withType: MockView2.self, animated: false, completion: {
            popToViewExpectation.fulfill()
        })
        XCTAssertTrue(sut.navigationStack.last?.type == MockView2.self)

        sut.popToView(withType: MockView1.self, animated: false, completion: {
            popToRootExpectation.fulfill()
        })
        XCTAssertTrue(sut.navigationStack.isEmpty)
        XCTAssertTrue(sut.rootView?.type == MockView1.self)

        wait(for: [popToViewExpectation, popToRootExpectation], timeout: 1)
    }

    func test_insertContentsViewsAtIndexZero_shouldInsertViewAtRootView() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        let v5 = AnyHashableView(MockView3())
        sut.insert(contentsOfViews: [v4, v5], at: 0, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView3.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[2].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[3].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 4)
    }

    func test_insertContentsViewsAtIndexOne_shouldInsertViewAtFirstIndexInStack() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        let v5 = AnyHashableView(MockView3())
        sut.insert(contentsOfViews: [v4, v5], at: 1, animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView3.self)
        XCTAssertTrue(sut.rootView?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[2].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[3].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 4)
    }

    func test_insertContentsViewsAtIndexTwo_shouldInsertViewAtSecondIndexInStack() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        let v5 = AnyHashableView(MockView3())
        sut.insert(contentsOfViews: [v4, v5], at: 2, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[0].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView2.self)
        XCTAssertTrue(sut.navigationStack[2].type == MockView3.self)
        XCTAssertTrue(sut.navigationStack[3].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 4)
    }

    func test_insertContentsViewsAtIndex_completionHandler() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        let v5 = AnyHashableView(MockView3())

        let expectation = XCTestExpectation()
        sut.insert(contentsOfViews: [v4, v5], at: 2, animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_insertViewAtIndexZero_shouldInsertViewAtRootView() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        sut.insert(v4, at: 0, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack[0].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[2].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 3)
    }

    func test_insertViewAtIndexOne_shouldInsertViewAtFirstIndexInStack() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())
        sut.setViews([v1, v2, v3], animated: true, completion: nil)

        let v4 = AnyHashableView(MockView2())
        sut.insert(v4, at: 1, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[2].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 3)
    }

    func test_insertViewAtIndex_completionHandler() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())

        let expectation = XCTestExpectation()
        sut.insert(v4, at: 2, animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_replaceViewAtIndexZero_shouldReplaceRootView() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        sut.replaceView(at: 0, with: v4, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 2)
    }

    func test_replaceViewAtIndexOne_shouldReplaceFirstViewAtStack() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        sut.replaceView(at: 1, with: v4, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 2)
    }

    func test_replaceFirstView_shouldReplaceRootView() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        sut.replaceFirstView(with: v4, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack[1].type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.count == 2)
    }

    func test_replaceLastView_shouldReplaceRootView() {
        let v1 = AnyHashableView(MockView1())
        let v2 = AnyHashableView(MockView1())
        let v3 = AnyHashableView(MockView1())

        sut.setViews([v1, v2, v3], animated: true, completion: nil)
        let v4 = AnyHashableView(MockView2())
        sut.replaceLastView(with: v4, animated: true, completion: nil)

        XCTAssertTrue(sut.rootView?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.first?.type == MockView1.self)
        XCTAssertTrue(sut.navigationStack.last?.type == MockView2.self)
        XCTAssertTrue(sut.navigationStack.count == 2)
    }

    func test_replaceViewAtIndex_completionHandler() {
        let v1 = AnyHashableView(MockView1())

        sut.setViews([v1], animated: true, completion: nil)
        let v2 = AnyHashableView(MockView2())

        let expectation = XCTestExpectation()
        sut.replaceView(at: 2, with: v2, animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_replaceFirstViewAtIndex_completionHandler() {
        let v1 = AnyHashableView(MockView1())

        sut.setViews([v1], animated: true, completion: nil)
        let v2 = AnyHashableView(MockView2())

        let expectation = XCTestExpectation()
        sut.replaceFirstView(with: v2, animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func test_replaceLastViewAtIndex_completionHandler() {
        let v1 = AnyHashableView(MockView1())

        sut.setViews([v1], animated: true, completion: nil)
        let v2 = AnyHashableView(MockView2())

        let expectation = XCTestExpectation()
        sut.replaceLastView(with: v2, animated: true, completion: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }
}

struct MockView1: View {
    var body: some View {
        Text("view 1")
    }
}

struct MockView2: View {
    var body: some View {
        Text("view 2")
    }
}

struct MockView3: View {
    var body: some View {
        Text("view 3")
    }
}
