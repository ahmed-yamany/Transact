//
//  HTTPClient+async.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 20/12/2024.
//

import Foundation

public extension HTTPClient {
    func perform(urlRequest: @escaping () -> URLRequest) async throws -> Response {
        var task: HTTPClientTask?

        return try await withTaskCancellationHandler {
            return try await withCheckedThrowingContinuation { continuation in
                task = perform(urlRequest: urlRequest) { result in
                    if Task.isCancelled {
                        return continuation.resume(throwing: CancellationError())
                    }

                    switch result {
                    case let .success(response):
                        continuation.resume(with: .success(response))
                    case let .failure(error):
                        continuation.resume(with: .failure(error))
                    }
                }
            }
        } onCancel: {
            task?.cancel()
        }
    }

    func perform(endpoint: @escaping () -> HTTPEndPoint) async throws -> HTTPClient.Response {
        try await perform(urlRequest: { URLRequest(endpoint: endpoint()) })
    }
}
