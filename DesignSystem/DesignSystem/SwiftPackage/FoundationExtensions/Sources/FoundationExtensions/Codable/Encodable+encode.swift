//
//  Encodable+encode.swift
//  
//
//  Created by Ahmed Yamany on 29/04/2024.
//

import Foundation

extension Encodable {
    func encode() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
