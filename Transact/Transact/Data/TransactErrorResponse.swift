//
//  TransactErrorResponse.swift
//  Transact
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Foundation

struct TransactErrorResponse: Decodable, Error, LocalizedError {
    let code: Int
    let message: String

    var errorDescription: String? { message }
}
