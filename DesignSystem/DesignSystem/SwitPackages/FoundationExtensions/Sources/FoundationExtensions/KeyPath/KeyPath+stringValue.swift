//
//  KeyPath+stringValue.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

public extension KeyPath {
    var stringValue: String {
        NSExpression(forKeyPath: self).keyPath
    }
}
