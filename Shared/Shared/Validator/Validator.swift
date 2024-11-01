//
//  Validator.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation

public protocol Validator {
    associatedtype T
    func validate(_ value: T) throws
}
