//
//  HTTPClientResponse+decode.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Foundation

public extension HTTPClientResponse {
    func decode<To: Decodable, ErrorDecodable: Decodable & Error>(
        to type: To.Type,
        errorType: ErrorDecodable.Type,
        using decoder: JSONDecoder = JSONDecoder()
    ) throws -> To {
        do {
            return try decoder.decode(type, from: data)
        } catch {
            if let result = try? decoder.decode(errorType, from: data) {
                throw result
            }

            throw error
        }
    }
}
