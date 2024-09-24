//
//  CollectionTests.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import XCTest
@testable import FoundationExtensions

final class CollectionTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSafe() throws {
        let array = Array(0...5)
        XCTAssertNil(array[safe: 7])
        XCTAssertTrue(array[safe: 0] == 0)
        XCTAssertTrue(array[safe: 1] == 1)
        XCTAssertTrue(array[safe: 2] == 2)
    }
}
