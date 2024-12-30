//
//  UIHashableHostingController.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 30/12/2024.
//
import SwiftUI

public class UIHashableHostingController: UIHostingController<AnyHashableView> {
    public let type: Any.Type

    override public init(rootView: AnyHashableView) {
        type = rootView.type
        super.init(rootView: rootView)
    }

    @MainActor @preconcurrency dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
