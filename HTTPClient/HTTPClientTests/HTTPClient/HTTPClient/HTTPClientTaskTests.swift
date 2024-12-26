//
//  HTTPClientTaskTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 23/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("HTTPClientTask")
struct HTTPClientTaskTests {
    @Test("Cancel calls wrapped task's cancel")
    func cancel_shouldInvokeWrappedTaskCancel() throws {
        // Arrange
        let mockTask = MockURLSessionTask()
        let taskWrapper = URLSessionTaskWrapper(wrapped: mockTask)

        // Act
        taskWrapper.cancel()

        // Assert
        #expect(mockTask.cancelCalled, "Calling cancel() on URLSessionTaskWrapper should invoke cancel() on the wrapped task.")
    }

    @Test("Conforms to HTTPClientTask protocol")
    func conformsToHTTPClientTaskProtocol() throws {
        // Arrange
        let mockTask = MockURLSessionTask()
        let taskWrapper: HTTPClientTask = URLSessionTaskWrapper(wrapped: mockTask)

        // Act
        taskWrapper.cancel()

        // Assert
        #expect((taskWrapper as? URLSessionTaskWrapper)?.wrapped === mockTask, "URLSessionTaskWrapper should conform to HTTPClientTask.")
        #expect(mockTask.cancelCalled, "Calling cancel() on the HTTPClientTask should invoke cancel() on the wrapped task.")
    }
}
