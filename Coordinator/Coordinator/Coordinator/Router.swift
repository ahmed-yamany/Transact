//
//  Router.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI

@MainActor
public protocol Router {
    var navigationController: UINavigationController { get }
    
    func push(_ view: some View, animated: Bool, completion: @escaping () -> Void)
    func setView(_ view: some View, animated: Bool, completion: @escaping () -> Void)
    func setViews(_ views: [some View], animated: Bool, completion: @escaping () -> Void)
    
    func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: @escaping () -> Void
    )
}
