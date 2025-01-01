//
//  TransactApp.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import Combine
import Coordinator
import HTTPClient
import SwiftUI

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var test = BinanceTradeStream(coin1: "btc", coin2: "usdt")

    var body: some Scene {
        WindowGroup {
            TransactCoordinator()
        }
    }
}


struct Message {
}

class BinanceTradeStream: ObservableObject {
    let domain = "stream.binance.com:9443"
    let trade = "trade"

    private let symbol: String
    private let socketURL: URL?

    let client = URLSessionWebSocketClient()

    var cancellables: Set<AnyCancellable> = []

    var response: AnyPublisher<URLSessionWebSocketTask.Message, Error>?

    init(
        coin1: String,
        coin2: String
    ) {
        symbol = "\(coin1)\(coin2)".lowercased()
        socketURL = URL(string: "wss://\(domain)/ws/\(symbol)@\(trade)")

        if let socketURL {
            // swiftlint: disable all
            client.perform(urlRequest: { URLRequest(url: socketURL) })

            client.stringMessages()
                .map { _ in Message() }
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        print(error)
                    }
                } receiveValue: { message in
                    print(message)
                }.store(in: &cancellables)
        }
    }
}
