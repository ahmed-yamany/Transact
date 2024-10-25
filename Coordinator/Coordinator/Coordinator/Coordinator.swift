//
//  Coordinator.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

@MainActor
public protocol Coordinator {
    var router: Router { get }

    func start()
}
