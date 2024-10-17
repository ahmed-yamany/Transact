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
    func push(contentsOf viewsToAppend: [some View], animated: Bool, completion: (() -> Void)?)
    
    func setView(_ view: some View, animated: Bool, completion: (() -> Void)?)
    func setViews(_ views: [some View], animated: Bool, completion: (() -> Void)?)
    
    func replaceLastView(with view: some View, animated: Bool, completion: (() -> Void)?)
    func replaceFirstView(with view: some View, animated: Bool, completion: (() -> Void)?)
    
    func insert(_ view: some View, at index: Int, animated: Bool, completion: (() -> Void)?)
    func insert(contentsOfViews viewsToInsert: [some View], at index: Int, animated: Bool, completion: (() -> Void)?)
    
    func pop(animated: Bool, completion: (() -> Void)?)
    func popToRoot(animated: Bool, completion: (() -> Void)?)
    
    func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    )
    func dismiss(animated: Bool, completion: (() -> Void)?)
}
