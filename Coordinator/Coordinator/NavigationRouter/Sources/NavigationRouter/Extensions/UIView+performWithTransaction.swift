//
//  UIView+performWithTransaction.swift
//  
//
//  Created by Ahmed Yamany on 02/08/2024.
//

import UIKit

public extension UIView {
    /// Performs an action with a transaction, executing a completion block after the transaction finishes.
    /// - Parameters:
    ///   - action: A closure that performs the action.
    ///   - completion: A closure to execute after the transaction completes.
    static func performWithTransaction(_ action: () -> Void, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        action()
        CATransaction.commit()
    }
}
