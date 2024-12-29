//
//  Router.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI

@MainActor
public protocol Router {
    func push(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?)
    func push(contentsOf viewsToAppend: [AnyHashableView], animated: Bool, completion: (() -> Void)?)

    func setView(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?)
    func setViews(_ views: [AnyHashableView], animated: Bool, completion: (() -> Void)?)

    func replaceLastView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?)
    func replaceFirstView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?)

    func insert(_ view: AnyHashableView, at index: Int, animated: Bool, completion: (() -> Void)?)
    func insert(contentsOfViews viewsToInsert: [AnyHashableView], at index: Int, animated: Bool, completion: (() -> Void)?)

    func pop(animated: Bool, completion: (() -> Void)?)
    func popToRoot(animated: Bool, completion: (() -> Void)?)

    func present(
        _ view: AnyHashableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    )
    func dismiss(animated: Bool, completion: (() -> Void)?)

    func popToView<T: View>(withType type: T.Type, animated: Bool, completion: (() -> Void)?)
}
