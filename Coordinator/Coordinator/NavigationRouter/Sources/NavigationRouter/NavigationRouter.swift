//
//  NavigationRouter.swift
//
//
//  Created by Ahmed Yamany on 01/08/2024.
//

import UIKit

/// A class that manages navigation actions for a `UINavigationController`.
@MainActor
public class NavigationRouter {
    /// The underlying `UINavigationController` instance.
    public let navigationController: UINavigationController

    /// Initializes a new instance of `NavigationRouter`.
    /// - Parameter navigationController: The `UINavigationController` to be managed by this router.
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// The navigation bar associated with the navigation controller.
    open var navigationBar: UINavigationBar {
        navigationController.navigationBar
    }

    /// The view controllers currently managed by the navigation controller.
    open var viewControllers: [UIViewController] {
        navigationController.viewControllers
    }

    /// Retrieves view controllers of a specific type from the navigation stack.
    /// - Parameter type: The type of the view controllers to retrieve.
    /// - Returns: An array of view controllers of the specified type.
    open func viewControllers<T: UIViewController>(ofType type: T.Type) -> [T] {
        return viewControllers.compactMap { $0 as? T }
    }

    /// The top view controller on the navigation stack.
    open var topViewController: UIViewController? {
        navigationController.topViewController
    }

    /// The visible view controller on the navigation stack.
    open var visibleViewController: UIViewController? {
        navigationController.visibleViewController
    }

    /// Checks if a specific view controller is in the navigation stack.
    /// - Parameter viewController: The view controller to check.
    /// - Returns: A boolean value indicating whether the view controller is in the stack.
    public func containsViewController(_ viewController: UIViewController) -> Bool {
        return viewControllers.contains(viewController)
    }

    /// Pushes a view controller onto the navigation stack with a completion handler.
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the push operation completes.
    public func push(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        UIView.performWithTransaction({
            navigationController.pushViewController(viewController, animated: animated)
        }, completion: completion)
    }

    /// Pushes multiple view controllers onto the navigation stack.
    /// - Parameters:
    ///   - viewControllersToAppend: An array of view controllers to push.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the push operation completes.
    public func push(contentsOf viewControllersToAppend: [UIViewController], animated: Bool = true, completion: @escaping () -> Void = {}) {
        setViewControllers(viewControllers + viewControllersToAppend, animated: animated, completion: completion)
    }

    /// Pushes a view controller if it does not already exist in the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the push operation completes.
    public func pushIfNotExists(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard !containsViewController(viewController) else {
            completion()
            return
        }
        push(viewController, animated: animated, completion: completion)
    }

    /// Pushes a view controller onto the navigation stack while respecting the safe area.
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the push operation completes.
    public func pushRespectingSafeArea(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        viewController.view.layoutIfNeeded()
        push(viewController, animated: animated, completion: completion)
    }

    /// Pushes a view controller with a custom animation.
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - animation: A closure defining the custom animation.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the push operation completes.
    public func push(
        _ viewController: UIViewController,
        withAnimation animation: @escaping ((containerView: UIView, viewController: UIViewController)) -> Void,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        if animated {
            UIView.transition(
                with: navigationController.view,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.navigationController.pushViewController(viewController, animated: false)
                },
                completion: { _ in
                    UIView.performWithTransaction({
                        animation((self.navigationController.view, viewController))
                    }, completion: completion)
                }
            )
        } else {
            UIView.performWithTransaction({
                navigationController.pushViewController(viewController, animated: false)
            }, completion: completion)
        }
    }

    /// Sets the view controllers of the navigation stack.
    /// - Parameters:
    ///   - viewControllers: An array of view controllers to set.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool = true, completion: @escaping () -> Void = {}) {
        UIView.performWithTransaction({
            navigationController.setViewControllers(viewControllers, animated: animated)
        }, completion: completion)
    }

    /// Sets a single view controller as the only view controller on the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to set.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func setViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        setViewControllers([viewController], animated: animated, completion: completion)
    }

    /// Replaces the last view controller on the navigation stack.
    /// - Parameters:
    ///   - viewController: The new view controller to replace the last one.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func replaceLastViewController(with viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        replaceViewController(at: viewControllers.count - 1, with: viewController)
    }

    /// Replaces the first view controller on the navigation stack.
    /// - Parameters:
    ///   - viewController: The new view controller to replace the first one.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func replaceFirstViewController(with viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        replaceViewController(at: 0, with: viewController)
    }

    /// Replaces a view controller at a specific index in the navigation stack.
    /// - Parameters:
    ///   - index: The index of the view controller to replace.
    ///   - viewController: The new view controller to replace the old one.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func replaceViewController(at index: Int, with viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewControllers = self.viewControllers.replacedElement(at: index, with: viewController)
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    /// Inserts a view controller at a specific index in the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to insert.
    ///   - index: The index at which to insert the view controller.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func insert(_ viewController: UIViewController, at index: Int, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewControllers = self.viewControllers.inserted(viewController, at: index)
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    /// Inserts a view controller after another view controller in the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to insert.
    ///   - afterViewController: The view controller after which to insert the new view controller.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func insert(_ viewController: UIViewController, after afterViewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard let afterIndex = viewControllers.firstIndex(where: { $0 === afterViewController }) else {
            fatalError("\(viewController) does not exist in the navigation stack")
        }
        insert(viewController, at: afterIndex + 1, animated: animated, completion: completion)
    }

    /// Inserts multiple view controllers at a specific index in the navigation stack.
    /// - Parameters:
    ///   - viewControllersToInsert: An array of view controllers to insert.
    ///   - index: The index at which to insert the view controllers.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func insert(contentsOfViewControllers viewControllersToInsert: [UIViewController], at index: Int, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let viewControllers = self.viewControllers.inserted(contentsOf: viewControllersToInsert, at: index)
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    /// Inserts multiple view controllers after another view controller in the navigation stack.
    /// - Parameters:
    ///   - viewControllersToInsert: An array of view controllers to insert.
    ///   - afterViewController: The view controller after which to insert the new view controllers.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func insert(contentsOfViewControllers viewControllersToInsert: [UIViewController], after afterViewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard let afterIndex = viewControllers.firstIndex(where: { $0 === afterViewController }) else {
            fatalError("\(viewControllersToInsert) does not exist in the navigation stack")
        }
        insert(contentsOfViewControllers: viewControllersToInsert, at: afterIndex + 1, animated: animated, completion: completion)
    }

    /// Pops to a specific view controller on the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to pop to.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    open func popToViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        UIView.performWithTransaction({
            navigationController.popToViewController(viewController, animated: animated)
        }, completion: completion)
    }

    /// Pops to the root view controller on the navigation stack.
    /// - Parameters:
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    open func popToRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        UIView.performWithTransaction({
            navigationController.popToRootViewController(animated: animated)
        }, completion: completion)
    }

    /// Pops a specific number of view controllers from the navigation stack.
    /// - Parameters:
    ///   - count: The number of view controllers to pop.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    @objc public func pop(count: Int = 1, animated: Bool = true, completion: @escaping () -> Void = {}) {
        if count == 1 {
            return UIView.performWithTransaction({
                navigationController.popViewController(animated: animated)
            }, completion: completion)
        }

        guard count > 0 else {
            fatalError("pop count is less than zero")
        }

        guard viewControllers.count > count else {
            fatalError("pop count is less than navigation stack count")
        }

        let targetViewController = viewControllers[viewControllers.count - count - 1]
        popToViewController(targetViewController, animated: animated, completion: completion)
    }

    /// Pops a specific number of view controllers from the navigation stack if a condition is met.
    /// - Parameters:
    ///   - count: The number of view controllers to pop.
    ///   - condition: A closure that returns a boolean indicating whether the condition is met.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func pop(count: Int, when condition: @escaping () -> Bool, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard condition() else {
            return completion()
        }
        return pop(count: count, animated: animated, completion: completion)
    }

    /// Pops to a view controller of a specific type on the navigation stack.
    /// - Parameters:
    ///   - type: The type of the view controller to pop to.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func popToViewController<T: UIViewController>(ofType type: T.Type, animated: Bool = true, completion: @escaping () -> Void = {}) {
        for vc in viewControllers.reversed() {
            if vc is T {
                return popToViewController(vc, animated: animated, completion: completion)
            }
        }
        completion()
    }

    /// Removes all view controllers from the navigation stack that satisfy a given predicate.
    /// - Parameters:
    ///   - predicate: A closure that returns a boolean indicating whether the view controller should be removed.
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func removeAll(where predicate: (UIViewController) -> Bool, animated: Bool = true, completion: @escaping () -> Void = {}) {
        let filteredViewControllers = viewControllers.filter { !predicate($0) }
        setViewControllers(filteredViewControllers, animated: animated, completion: completion)
    }

    /// Removes the root view controller from the navigation stack.
    /// - Parameters:
    ///   - animated: A boolean indicating whether the transition is animated.
    ///   - completion: A closure to execute after the operation completes.
    public func removeRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        var viewControllers = self.viewControllers
        viewControllers.removeFirst()
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    /// Sets the visibility of the back button for the visible view controller.
    /// - Parameters:
    ///   - hidesBackButton: A boolean indicating whether the back button should be hidden.
    ///   - animated: A boolean indicating whether the transition is animated.
    public func setHidesVisibleViewControllerBackButton(_ hidesBackButton: Bool, animated: Bool) {
        visibleViewController?.navigationItem.setHidesBackButton(hidesBackButton, animated: animated)
    }

    /// Sets the visibility of the navigation bar.
    /// - Parameters:
    ///   - hidden: A boolean indicating whether the navigation bar should be hidden.
    ///   - animated: A boolean indicating whether the transition is animated.
    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool = true) {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }

    /// Sets a custom image for the back button.
    /// - Parameter image: The image to use for the back button.
    public func setBackButtonImage(_ image: UIImage?) {
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
    }

    /// Sets the title for the back button of the visible view controller.
    /// - Parameter title: The title to set for the back button.
    public func setVisibleViewControllerBackButtonTitle(_ title: String) {
        visibleViewController?.navigationItem.backButtonTitle = title
    }

    /// Sets the visibility of the toolbar.
    /// - Parameters:
    ///   - hidden: A boolean indicating whether the toolbar should be hidden.
    ///   - animated: A boolean indicating whether the transition is animated.
    public func setToolbarHidden(_ hidden: Bool, animated: Bool) {
        navigationController.setToolbarHidden(hidden, animated: animated)
    }

    /// Sets the toolbar items for the navigation controller.
    /// - Parameters:
    ///   - toolbarItems: An array of `UIBarButtonItem` to set for the toolbar.
    ///   - animated: A boolean indicating whether the transition is animated.
    public func setToolbarItems(_ toolbarItems: [UIBarButtonItem]?, animated: Bool) {
        navigationController.setToolbarItems(toolbarItems, animated: animated)
    }

    /// A boolean indicating whether the navigation bar hides when the keyboard appears.
    open var hidesBarsWhenKeyboardAppears: Bool {
        get {
            navigationController.hidesBarsWhenKeyboardAppears
        } set {
            navigationController.hidesBarsWhenKeyboardAppears = newValue
        }
    }

    /// A boolean indicating whether the navigation bar hides on swipe.
    open var hidesBarsOnSwipe: Bool {
        get {
            navigationController.hidesBarsOnSwipe
        } set {
            navigationController.hidesBarsOnSwipe = newValue
        }
    }

    /// A boolean indicating whether the navigation bar hides when the view is vertically compact.
    open var hidesBarsWhenVerticallyCompact: Bool {
        get {
            navigationController.hidesBarsWhenVerticallyCompact
        } set {
            navigationController.hidesBarsWhenVerticallyCompact = newValue
        }
    }

    /// A boolean indicating whether the navigation bar hides on tap.
    open var hidesBarsOnTap: Bool {
        get {
            navigationController.hidesBarsOnTap
        } set {
            navigationController.hidesBarsOnTap = newValue
        }
    }
}
