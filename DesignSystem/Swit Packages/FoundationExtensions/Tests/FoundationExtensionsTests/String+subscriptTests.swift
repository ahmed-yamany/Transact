//
//  String+subscriptTests.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import XCTest

final class String_subscriptTests: XCTestCase {

    func testStringSubscript() throws {
        let string = "Hello World!"
        XCTAssertTrue(string[0] == "H")
        XCTAssertTrue(string[2] == "l")
        XCTAssertTrue(string[0..<2] == "He")
        XCTAssertTrue(string[6...10] == "World")
        XCTAssertTrue(string[6...] == "World!")
        XCTAssertNil(string[safe: 12])
        XCTAssertTrue(string[safe: 2] == "l")
        XCTAssertNil(string[0..<30])
        XCTAssertNil(string[6...30])
        XCTAssertNil(string[40...])
    }
}
