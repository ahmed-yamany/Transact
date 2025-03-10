//
//  UIView+parentViewController.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 31/12/2024.
//

import UIKit

extension UIView {
    /// Returns the nearest parent view controller for the current view.
    var parentViewController: UIViewController? {
        sequence(first: self) {
            $0.next
        }.first { $0 is UIViewController } as? UIViewController
    }
}
