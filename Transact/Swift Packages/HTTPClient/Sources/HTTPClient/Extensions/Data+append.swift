//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
