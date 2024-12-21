//
//  HTTPClient+decode.swift
//  Transact
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Foundation
import HTTPClient

extension HTTPClientResponse {
    func decode<To: Decodable>(to type: To.Type) throws -> To {
        try decode(to: type, errorType: TransactErrorResponse.self, using: JSONDecoder())
    }
}

extension HTTPClient {
    func perform<T: Decodable>(endpoint: @escaping () async -> HTTPEndPoint) async throws -> T {
        try await perform(endpoint: endpoint).decode(to: T.self)
    }
}
