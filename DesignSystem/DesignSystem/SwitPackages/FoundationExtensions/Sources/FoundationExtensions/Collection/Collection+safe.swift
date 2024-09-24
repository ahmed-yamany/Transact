//
//  Collection+safe.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

public extension Collection {
    /// Safely retrieves an element at the specified index, if it exists.
    ///
    /// - Parameter index: The index of the element to retrieve.
    /// - Returns: The element at the specified index, or `nil` if the index is out of bounds.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
