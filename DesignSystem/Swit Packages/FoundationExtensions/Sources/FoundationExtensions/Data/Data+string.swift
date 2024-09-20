//
//  Data+string.swift
//
//
//  Created by Ahmed Yamany on 29/04/2024.
//

import Foundation

public extension Data {
    func string() -> String? {
        String(data: self, encoding: .utf8)
    }
}
