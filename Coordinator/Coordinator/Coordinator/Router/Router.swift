//
//  Router.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI

@MainActor
public protocol Router {
    func push(_ view: some RoutableView, animated: Bool, completion: @escaping () -> Void)
    func setView(_ view: some RoutableView, animated: Bool, completion: @escaping () -> Void)
    func setViews(_ views: [some RoutableView], animated: Bool, completion: @escaping () -> Void)
    
    func present(
        _ view: some RoutableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: @escaping () -> Void
    )
}
