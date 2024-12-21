//
//  MultiPartWrapperTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("MultiPartWrapper Tests")
struct MultiPartWrapperTests {
    func makeItem(objectDic: [String: Any], type: MimeType) -> MultipartItem {
        let boundary = UUID().uuidString
        return MultipartItem(boundary: boundary, objectDic: objectDic, type: type)
    }

    func makeSutResult(items: [MultipartItem], sourceLocation: SourceLocation = #_sourceLocation) throws -> String {
        let wrapper = MultiPartWrapper(items: items)
        let data = try #require(wrapper.wrap(), sourceLocation: sourceLocation)
        return try #require(String(data: data, encoding: .utf8), sourceLocation: sourceLocation)
    }

    @Test("Correctly encodes multipart data with string values")
    func testWrap_withStringValues() throws {
        let item = makeItem(objectDic: ["name": "John Doe"], type: .jpeg)
        let result = try makeSutResult(items: [item])

        #expect(result.contains("Content-Disposition: form-data; name=\"name\""), "String values should have correct content disposition")
        #expect(result.contains("John Doe"), "String value should be included in the body")
    }

    @Test("Correctly encodes multipart data with data values")
    func testWrap_withDataValues() throws {
        let dataValue = "Sample Image".data(using: .utf8)!
        let item = makeItem(objectDic: ["file": dataValue], type: .jpeg)
        let result = try makeSutResult(items: [item])

        #expect(result.contains("Content-Disposition: form-data; name=\"file\"; filename=\""), "Data values should have correct content disposition")
        #expect(result.contains("Content-Type: image/jpeg"), "Data values should include correct content type")
        #expect(result.contains("Sample Image"), "Data value content should be included in the body")
    }

    @Test("Correctly encodes multipart data with NSNumber values")
    func testWrap_withNSNumberValues() throws {
        let item = makeItem(objectDic: ["age": NSNumber(value: 25)], type: .json)
        let result = try makeSutResult(items: [item])

        #expect(result.contains("Content-Disposition: form-data; name=\"age\""), "NSNumber values should have correct content disposition")
        #expect(result.contains("25"), "NSNumber value content should be included in the body")
    }

    @Test("Handles multiple items correctly")
    func testWrap_withMultipleItems() throws {
        let item1 = makeItem(objectDic: ["name": "John Doe"], type: .jpeg)
        let item2 = makeItem(objectDic: ["file": "File Content".data(using: .utf8)!], type: .json)

        let result = try makeSutResult(items: [item1, item2])

        #expect(result.contains("Content-Disposition: form-data; name=\"name\""), "First item's key should be included")
        #expect(result.contains("Content-Disposition: form-data; name=\"file\"; filename=\""), "Second item's key should be included")
        #expect(result.contains("File Content"), "Second item's value content should be included")
        #expect(result.contains("--\(item1.boundary)--"), "Boundary should terminate the multipart body correctly")
    }

    @Test("Handles empty object dictionary")
    func testWrap_withEmptyObjectDictionary() throws {
        let item = makeItem(objectDic: [:], type: .jpeg)
        let result = try makeSutResult(items: [item])

        #expect(result == "--\(item.boundary)--\r\n", "Empty object dictionary should result in only the boundary termination")
    }

    @Test("Handles empty item array")
    func testWrap_withEmptyItems() throws {
        let result = try makeSutResult(items: [])
        #expect(result == "", "Empty item array should result in an empty string")
    }
}
