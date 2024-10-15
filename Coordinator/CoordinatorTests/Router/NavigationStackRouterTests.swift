//
//  NavigationStackRouterTests.swift
//  CoordinatorTests
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import XCTest
@testable import Coordinator
import SwiftUI

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
    func test_NavigationStackRouter_WhenPushOneView_RootViewShouldNotBeNilAndStackEmpty() {
        XCTAssertNil(sut.rootView)
        sut.push(Text(""), animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "NavigationStackRouter RootView is Nil When Pushing One View")
        XCTAssertTrue(sut.stack.isEmpty, "NavigationStackRouter Stack is Not Empty When Pushing One View")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenPushingTwoView_StackCountShouldBeOneAndRootViewNotNil() {
        sut.push(Text(""), animated: true, completion: nil)
        sut.push(Text(""), animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "Root view should be set")
        XCTAssertFalse(sut.stack.isEmpty, "NavigationStackRouter Stack is Empty When Pushing More Than One View")
        XCTAssertEqual(sut.stack.count, 1, "NavigationStackRouter Stack Count is not 1 when pushing two views")
    }
    
    @MainActor
    func test_NavigationStackRouter_SetView_shouldReplaceRootView() {
        let firstView = Text("First View")
        let secondView = Text("Second View")
        
        sut.setView(firstView, animated: false, completion: nil)
        sut.setView(secondView, animated: false, completion: nil)
        
        XCTAssertTrue(sut.stack.isEmpty, "Stack should remain empty when using setView")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenPushingWithAnimation_TransitionShouldEnableAnimation() {
        sut.push(Text(""), animated: true, completion: nil)
        XCTAssertFalse(sut.transaction.disablesAnimations, "Transiotion Should Enable Animation when animated is true")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenPushingWithoutAnimation_TransitionShouldDisableAnimation() {
        sut.push(Text(""), animated: false, completion: nil)
        XCTAssertTrue(sut.transaction.disablesAnimations, "Transiotion Should Disable Animation when animated is false")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenSettingEmptyViews_RootViewShouldBeNil() {
        let views: [AnyView] = []
        sut.setViews(views, animated: true, completion: nil)
        XCTAssertNil(sut.rootView, "rootView should be nil when settings empty array")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenSettingOneView_RootViewShouldNotBeNilAndStackShouldBeNil() {
        sut.setViews([Text(""), Text(""), Text("")], animated: true, completion: nil)
        sut.setViews([Text("")], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting one view")
        XCTAssertTrue(sut.stack.isEmpty, "stack must be empty when settings one view")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenSettingTwoViews_StackCountShouldBeOne() {
        sut.setViews([Text(""), Text("")], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting two views")
        XCTAssertEqual(sut.stack.count, 1, "stack count must be one when setting two views")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenSettingTwoViews_StackCountShouldBeOne_1() {
        sut.setViews([Text(""), Text(""), Text(""), Text("")], animated: true, completion: nil)        
        sut.setViews([Text(""), Text("")], animated: true, completion: nil)
        XCTAssertNotNil(sut.rootView, "rootView should not be nil when setting two views")
        XCTAssertEqual(sut.stack.count, 1, "stack count must be one when setting two views")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenReSettingViews_RootViewShouldBeNilAndStackEmpty() {
        sut.setViews([Text(""), Text("")], animated: true, completion: nil)
        let views: [AnyView] = []
        sut.setViews(views, animated: true, completion: nil)
        XCTAssertNil(sut.rootView, "rootView should be nil when reseting views")
        XCTAssertTrue(sut.stack.isEmpty, "stack should be empty when reseting views")
    }
}
