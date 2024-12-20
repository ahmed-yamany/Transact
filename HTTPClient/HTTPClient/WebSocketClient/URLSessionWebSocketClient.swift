//
//  URLSessionWebSocketClient.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 14/12/2024.
//

import Combine
import Foundation

public class URLSessionWebSocketClient {
    public private(set) var webSocketTask: URLSessionWebSocketTask?

    private let session: URLSession
    private let messages = PassthroughSubject<URLSessionWebSocketTask.Message, Error>()
    private let statePublisher = CurrentValueSubject<URLSessionWebSocketTask.State, Never>(.suspended)
    private var reconnectCancellable: AnyCancellable?

    public var connectionState: AnyPublisher<URLSessionWebSocketTask.State, Never> {
        statePublisher.eraseToAnyPublisher()
    }

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    deinit {
        shutdown()
    }

    open func perform(urlRequest: @escaping () -> URLRequest) {
        let webSocket = session.webSocketTask(with: urlRequest())

        webSocketTask = webSocket
        webSocket.resume()
        updateConnectionState()
        waitForNextValue()
    }

    public func reconnect() {
        guard let originalRequest = webSocketTask?.originalRequest else { return }
        perform(urlRequest: { originalRequest })
    }

    open func send(_ message: URLSessionWebSocketTask.Message) async throws {
        guard let webSocketTask else {
            throw URLError(.badServerResponse)
        }

        try await webSocketTask.send(message)
    }

    open func sendPing(interval: TimeInterval = 30) {
        guard let webSocketTask else { return }
        webSocketTask.sendPing { [weak self] error in
            if let error = error {
                self?.messages.send(completion: .failure(error))
            } else {
                DispatchQueue.global().asyncAfter(deadline: .now() + interval) {
                    self?.sendPing(interval: interval)
                }
            }
        }
    }

    open func cancel(with closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        webSocketTask?.cancel(with: closeCode, reason: reason)
        messages.send(completion: .finished)
        statePublisher.send(.canceling)
    }

    open func shutdown() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        messages.send(completion: .finished)
        statePublisher.send(completion: .finished)
    }

    public func stringMessages() -> AnyPublisher<String, Error> {
        messages
            .compactMap { message -> String? in
                if case let .string(text) = message {
                    return text
                }
                return nil
            }
            .eraseToAnyPublisher()
    }

    public func dataMessages() -> AnyPublisher<Data, Error> {
        messages
            .compactMap { message -> Data? in
                if case let .data(data) = message {
                    return data
                }
                return nil
            }
            .eraseToAnyPublisher()
    }

    private func waitForNextValue() {
        guard let webSocketTask, webSocketTask.state == .running else {
            messages.send(completion: .finished)
            return
        }

        webSocketTask.receive { [weak self] result in
            switch result {
            case let .success(message):
                self?.messages.send(message)
                self?.waitForNextValue()
            case let .failure(error):
                self?.messages.send(completion: .failure(error))
                self?.updateConnectionState()
            }
        }
    }

    private func updateConnectionState() {
        guard let webSocketTask else { return }
        statePublisher.send(webSocketTask.state)
    }
}
