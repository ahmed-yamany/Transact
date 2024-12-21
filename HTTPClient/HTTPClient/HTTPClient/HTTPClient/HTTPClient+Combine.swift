//
//  HTTPClient+Combine.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 20/12/2024.
//

import Combine
import Foundation

public extension HTTPClient {
    typealias PublisherResult = AnyPublisher<HTTPClientResponse, Error>

    func perform(urlRequest: @escaping () -> URLRequest) -> Self.PublisherResult {
        var task: HTTPClientTask?
        return Future { promise in
            task = perform(urlRequest: urlRequest) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.handleEvents(receiveCancel: {
            task?.cancel()
        }).eraseToAnyPublisher()
    }

    func perform(endpoint: @escaping () -> HTTPEndPoint) -> Self.PublisherResult {
        perform(urlRequest: { URLRequest(endpoint: endpoint()) })
    }
}
