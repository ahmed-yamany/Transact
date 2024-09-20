//
//  Array+nextElementTo.swift
//
//  Created by Ahmed Yamany on 26/07/2024.
//

import Foundation

public extension Array where Element: Hashable {
    func nextElement(to element: Element) -> Element? {
        if let index = self.firstIndex(of: element) {
            return self[safe: index + 1]
        }
        return nil
    }
}
