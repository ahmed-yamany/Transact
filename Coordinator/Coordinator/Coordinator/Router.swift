//
//  Router.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI

@MainActor
public protocol Router {
    func push(_ view: some View, animated: Bool, completion: (() -> Void)?)
    func setView(_ view: some View, animated: Bool, completion: (() -> Void)?)
    func setViews(_ views: [some View], animated: Bool, completion: (() -> Void)?)
    
    func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    )
}
