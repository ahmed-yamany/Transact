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
        sut.push(Text(""), animated: true, completion: {})
        XCTAssertNotNil(sut.rootView, "NavigationStackRouter RootView is Nil When Pushing One View")
        XCTAssertTrue(sut.stack.isEmpty, "NavigationStackRouter Stack is Not Empty When Pushing One View")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenPushingTwoView_StackCountShouldBeOne() {
        sut.push(Text(""), animated: true, completion: {})
        sut.push(Text(""), animated: true, completion: {})
        XCTAssertFalse(sut.stack.isEmpty, "NavigationStackRouter Stack is Empty When Pushing More Than One View")
        XCTAssertEqual(sut.stack.count, 1, "NavigationStackRouter Stack Count is not 1 when pushing two views")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenPushingWithAnimation_TransitionShouldEnableAnimation() {
        sut.push(Text(""), animated: true, completion: {})
        XCTAssertFalse(sut.transaction.disablesAnimations, "Transiotion Should Enable Animation when animated is true")
    }
    
    @MainActor
    func test_NavigationStackRouter_WhenPushingWithoutAnimation_TransitionShouldDisableAnimation() {
        sut.push(Text(""), animated: false, completion: {})
        XCTAssertTrue(sut.transaction.disablesAnimations, "Transiotion Should Disable Animation when animated is false")
    }
}
