//
//  Created by Ahmed Yamany on 19/06/2024.
//
#if os(iOS)
import SwiftUI

private struct NavigationControllerViewRepresentable: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UINavigationController
    
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}

public struct NavigationControllerView: View {
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public var body: some View {
        NavigationControllerViewRepresentable(navigationController: navigationController)
            .ignoresSafeArea()
    }
}
#endif
