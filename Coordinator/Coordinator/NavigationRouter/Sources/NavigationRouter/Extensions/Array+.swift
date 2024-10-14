//
//  Array+.swift
//  
//
//  Created by Ahmed Yamany on 02/08/2024.
//

import Foundation

public extension Array {
    func removedFirst() -> Self {
        guard !isEmpty else { return self }
        return Array(dropFirst())
    }
    
    func removedLast() -> Self {
        guard !isEmpty else { return self }
        return Array(dropLast())
    }
    
    func inserted(_ element: Element, at index: Int) -> [Element] {
        var newArray = self
        newArray.insert(element, at: index)
        return newArray
    }
    
    func inserted(contentsOf elements: [Element], at index: Int) -> [Element] {
        var newArray = self
        newArray.insert(contentsOf: elements, at: index)
        return newArray
    }
    
    func replacedElement(at index: Int, with element: Element) -> [Element] {
        guard index >= 0 && index < count else {
            return self
        }
        var newArray = self
        newArray[index] = element
        return newArray
    }
}
