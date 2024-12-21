//
//  HTTPClient+async.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 20/12/2024.
//

import Foundation

public extension HTTPClient {
    func perform(urlRequest: @escaping () async -> URLRequest) async throws -> HTTPClientResponse {
        var taskStore = TaskStore()

        let urlRequest = await urlRequest()
        return try await withTaskCancellationHandler {
            return try await withCheckedThrowingContinuation { continuation in
                let task = perform(urlRequest: { urlRequest }) { result in
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

                taskStore.store(task: task)
            }
        } onCancel: {
            taskStore.cancel()
        }
    }

    func perform(endpoint: @escaping () async -> HTTPEndPoint) async throws -> HTTPClientResponse {
        try await perform(urlRequest: { await URLRequest(endpoint: endpoint()) })
    }
}

private final class TaskStore {
    var task: HTTPClientTask?
    let lock = NSLock()
    
    func store(task: HTTPClientTask) {
        lock.lock()
        self.task = task
        lock.unlock()
    }

    func cancel() {
        lock.lock()
        task?.cancel()
        lock.unlock()
    }
}
