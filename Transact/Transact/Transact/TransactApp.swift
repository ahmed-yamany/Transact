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

extension NavigationControllerManager: @retroactive ObservableObject {}

@main
struct TransactApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var test = BinanceTradeStream(coin1: "btc", coin2: "usdt")
    @StateObject var manager = createManager()

    var body: some Scene {
        WindowGroup {
//            RepresentableViewController(viewController: manager.navigationController)
//                .tint(.black)
//                .ignoresSafeArea()
//                .onAppear {
//                    manager.setViewControllers([BlueVC(), RedVC()])
//                    manager.replaceLastViewController(with: YellowVC())
//                }
            
            TransactCoordinator()
//                .onAppear {
//                }
        }
    }
}

class BlueVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

class RedVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class YellowVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

@MainActor
func createManager() -> NavigationControllerManager {
    return NavigationControllerManager(navigationController: .init())
}

struct RepresentableViewController: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
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
