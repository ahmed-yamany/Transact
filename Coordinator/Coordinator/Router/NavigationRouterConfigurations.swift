//
//  NavigationRouterConfigurations.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 31/12/2024.
//
import UIKit

public struct NavigationRouterConfigurations: Equatable {
    public var backButtonImage: UIImage?
    public var hideNavigationBar: Bool

    public init(backButtonImage: UIImage? = nil, hideNavigationBar: Bool = false) {
        self.backButtonImage = backButtonImage
        self.hideNavigationBar = hideNavigationBar
    }
}
