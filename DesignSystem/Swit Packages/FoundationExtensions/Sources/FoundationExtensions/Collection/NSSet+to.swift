//
//  NSSet+to.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

public extension NSSet {
    func toArray<T>() -> [T] {
        map({ $0 as? T }).compactMap { $0 }
    }
}
