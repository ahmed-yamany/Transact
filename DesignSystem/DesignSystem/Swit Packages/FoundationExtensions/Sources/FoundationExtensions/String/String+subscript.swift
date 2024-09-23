//
//  String+subscript.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

public extension String {
    
    /**
     - Example:
     ```
     let str = "Hello"
     let char = str[1]
     // char is "e"
     ```
     */
    subscript(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    /**
     - Example:
     ```
     let str = "Swift Programming"
     let substring = str[safe: 30]
     // substring is nil
     ```
     */
    subscript(safe index: Int) -> Character? {
        return indices.contains(Index(utf16Offset: index, in: self)) ? self[index] : nil
    }

    /**
     - Example:
     ```
     let str = "Swift Programming"
     let substring = str[6...11]
     // substring is "Progra"
     ```
     */
    subscript (_ bounds: CountableClosedRange<Int>) -> Self.SubSequence? {
        if bounds.upperBound > count - 1 || bounds.upperBound > count - 1 {
            return nil
        }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start...end]
    }

    /**
     Example:
     ```
     let str = "Swift Programming"
     let substring = str[6..<12]
     // substring is "Progra"
     ```
     */
    subscript (_ bounds: CountableRange<Int>) -> Self.SubSequence? {
        if bounds.upperBound > count - 1 || bounds.upperBound > count - 1 {
            return nil
        }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound - 1)
        return self[start...end]
    }
    
    /**
    - Example:
    ```
    let str = "Swift Programming"
    let substring = str[2...]
    // substring is "ift Programming"
    ```
    */
    subscript(bounds: CountablePartialRangeFrom<Int>) -> Self.SubSequence? {
        if bounds.lowerBound > count - 1 {
            return nil
        }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        return self[start...]
    }
}
