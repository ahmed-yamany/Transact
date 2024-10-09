//
//  View+LifeCycle.swift
//
//
//  Created by Ahmed Yamany on 28/07/2024.
//

import SwiftUI

public extension View {
    func viewWillAppear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(onWillAppear: perform))
    }
    
    func viewDidAppear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(onDidAppear: perform))
    }
    
    func viewDidLoad(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(onDidLoad: perform))
    }
    
    func viewWillDisappear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(onWillDisappear: perform))
    }
    
    func viewDidDisappear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(onDidDisappear: perform))
    }
    
    func viewIsAppearing(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(onIsAppearing: perform))
    }
}

private struct WillAppearModifier: ViewModifier {
    var onWillAppear: () -> Void = {}
    var onDidAppear: () -> Void = {}
    var onDidLoad: () -> Void = {}
    var onWillDisappear: () -> Void = {}
    var onDidDisappear: () -> Void = {}
    var onIsAppearing: () -> Void = {}
    
    func body(content: Content) -> some View {
        content.background(
            UIViewLifeCycleHandler(
                onWillAppear: onWillAppear,
                onDidAppear: onDidAppear,
                onDidLoad: onDidLoad,
                onWillDisappear: onWillDisappear,
                onDidDisappear: onDidDisappear,
                onIsAppearing: onIsAppearing
            )
        )
    }
}

private struct UIViewLifeCycleHandler: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    var onWillAppear: () -> Void = {}
    var onDidAppear: () -> Void = {}
    var onDidLoad: () -> Void = {}
    var onWillDisappear: () -> Void = {}
    var onDidDisappear: () -> Void = {}
    var onIsAppearing: () -> Void = {}

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
        context.coordinator
    }

    func updateUIViewController(
        _: UIViewControllerType,
        context _: UIViewControllerRepresentableContext<Self>
    ) { }

    func makeCoordinator() -> Self.Coordinator {
        Coordinator(
            onWillAppear: onWillAppear,
            onDidAppear: onDidAppear,
            onDidLoad: onDidLoad,
            onWillDisappear: onWillDisappear,
            onDidDisappear: onDidDisappear,
            onIsAppearing: onIsAppearing
        )
    }

    class Coordinator: UIViewControllerType {
        let onWillAppear: () -> Void
        let onDidAppear: () -> Void
        let onDidLoad: () -> Void
        let onWillDisappear: () -> Void
        let onDidDisappear: () -> Void
        let onIsAppearing: () -> Void
        
        init(
            onWillAppear: @escaping () -> Void,
            onDidAppear: @escaping () -> Void,
            onDidLoad: @escaping () -> Void,
            onWillDisappear: @escaping () -> Void,
            onDidDisappear: @escaping () -> Void,
            onIsAppearing: @escaping () -> Void
        ) {
            self.onWillAppear = onWillAppear
            self.onDidAppear = onDidAppear
            self.onDidLoad = onDidLoad
            self.onWillDisappear = onWillDisappear
            self.onDidDisappear = onDidDisappear
            self.onIsAppearing = onIsAppearing
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onDidAppear()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            onDidLoad()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDidDisappear()
        }
        
        override func viewIsAppearing(_ animated: Bool) {
            super.viewIsAppearing(animated)
            onIsAppearing()
        }
    }
}
