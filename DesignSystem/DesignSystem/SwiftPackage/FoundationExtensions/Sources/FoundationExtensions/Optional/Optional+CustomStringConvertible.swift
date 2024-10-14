//
//  Optional+CustomStringConvertible.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

extension Optional: CustomStringConvertible where Wrapped == String {
    public var description: String {
        return self ?? ""
    }
}
