//
//  UIApplication+mainWindow.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UIApplication {
    /// Returns the main UIWindow of the application, if available.
    ///
    /// This property searches for the main UIWindow among all connected UIWindowScenes.
    ///
    /// - Note: If no key window is found among the connected scenes, this property returns nil.
    ///
    /// - Returns: The main UIWindow of the application, or nil if none is found.
    var mainWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}
#endif
