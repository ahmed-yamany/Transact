//
//  PresentationRouter.swift
//
//
//  Created by Ahmed Yamany on 31/07/2024.
//

import os
import UIKit

/// A delegate protocol to notify about significant events in `PresentationRouter`.
@MainActor
public protocol PresentationRouterDelegate: AnyObject {
    /// Called when a view controller has been presented.
    ///
    /// - Parameter viewController: The view controller that has been presented.
    func didPresentViewController(_ viewController: UIViewController)

    /// Called when a view controller has been dismissed.
    ///
    /// - Parameter viewController: The view controller that has been dismissed.
    func didDismissViewController(_ viewController: UIViewController)

    /// Called when an error occurs within the `PresentationRouter`.
    ///
    /// - Parameter error: The error that occurred.
    func didEncounterError(_ error: Error)
}

/// A class responsible for managing the presentation and dismissal of view controllers.
@MainActor
open class PresentationRouter {
    
    /// The root view controller from which other view controllers will be presented.
    public let rootViewController: UIViewController
    
    /// A delegate to notify about presentation events and errors.
    public weak var delegate: PresentationRouterDelegate?
    
    /// Initializes a new `PresentationRouter`.
    ///
    /// - Parameters:
    ///   - rootViewController: The root view controller from which other view controllers will be presented.
    ///   - delegate: An optional delegate to notify about presentation events and errors.
    public init(rootViewController: UIViewController, delegate: PresentationRouterDelegate? = nil) {
        self.rootViewController = rootViewController
        self.delegate = delegate
    }
    
    /// The stack of currently presented view controllers.
    open var viewControllers: [UIViewController] {
        var stack: [UIViewController] = []
        
        if var currentViewController = rootViewController.presentedViewController {
            stack.append(currentViewController)
            while let nextViewController = currentViewController.presentedViewController {
                currentViewController = nextViewController
                stack.append(currentViewController)
            }
        }
        return stack
    }
    
    /// The top-most presented view controller.
    public var presentedViewController: UIViewController {
        guard let presentedViewController = viewControllers.last else {
            return rootViewController
        }
        
        return presentedViewController
    }
    
    /// The sheet presentation controller of the top-most presented view controller.
    @available(iOS 15.0, *)
    public var sheetPresentationController: UISheetPresentationController? {
        presentedViewController.sheetPresentationController
    }
    
    /// Presents a view controller.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - animated: Whether to animate the presentation. Default is `true`.
    ///   - presentationStyle: The modal presentation style to use. Default is `.automatic`.
    ///   - transitionStyle: The modal transition style to use. Default is `.coverVertical`.
    ///   - completion: A closure to be called after the presentation finishes. Default is an empty closure.
    public func present(
        _ viewController: UIViewController,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        
        present(viewController, on: presentedViewController, animated: animated, completion: completion)
    }
    
    private func present(
        _ viewController: UIViewController,
        on presentingViewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void
    ) {
        presentingViewController.present(viewController, animated: animated) { [weak self] in
            guard let self else { return }
            delegate?.didPresentViewController(viewController)
            completion()
        }
    }
    
    public func present(
        contentsOf viewControllersToPresent: [UIViewController],
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        guard let viewControllerToPresent = viewControllersToPresent.first else {
            return completion()
        }
        present(
            viewControllerToPresent,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle
        ) { [weak self] in
            guard let self else { return }
            present(
                contentsOf: viewControllersToPresent.removedFirst(),
                animated: animated,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                completion: completion
            )
        }
    }
    
    
    /// Dismisses the top-most presented view controller.
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the dismissal. Default is `true`.
    ///   - completion: A closure to be called after the dismissal finishes. Default is an empty closure.
    public func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard let lastPresentingViewController = presentedViewController.presentingViewController else {
            if #available(iOS 14.0, *) {
                logError("Attempt to dismiss while the presentation stack is empty")
            }
            return
        }
        
        lastPresentingViewController.dismiss(animated: animated) { [weak self] in
            guard let self else { return }
            delegate?.didDismissViewController(lastPresentingViewController)
            completion()
        }
    }
    
    /// Dismisses all presented view controllers back to the root view controller.
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the dismissal. Default is `true`.
    ///   - completion: A closure to be called after the dismissal finishes. Default is an empty closure.
    public func dismissToRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard presentedViewController.presentingViewController != nil else {
            return completion()
        }
        
        dismiss(animated: animated) { [weak self] in
            guard let self else { return }
            dismissToRoot(animated: animated, completion: completion)
        }
    }
    
    /// Replaces the last presented view controller with a new one.
    ///
    /// - Parameters:
    ///   - viewController: The new view controller to present.
    ///   - animated: Whether to animate the presentation. Default is `true`.
    ///   - presentationStyle: The modal presentation style to use. Default is `.automatic`.
    ///   - transitionStyle: The modal transition style to use. Default is `.coverVertical`.
    ///   - completion: A closure to be called after the presentation finishes. Default is an empty closure.
    public func replaceLastViewController(
        with viewController: UIViewController,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        dismiss(animated: animated) { [weak self] in
            guard let self else { return }
            present(
                viewController,
                animated: animated,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                completion: completion
            )
        }
    }
    
    /// Replaces the first presented view controller with a new one.
    ///
    /// - Parameters:
    ///   - viewController: The new view controller to present.
    ///   - animated: Whether to animate the presentation. Default is `true`.
    ///   - presentationStyle: The modal presentation style to use. Default is `.automatic`.
    ///   - transitionStyle: The modal transition style to use. Default is `.coverVertical`.
    ///   - completion: A closure to be called after the presentation finishes. Default is an empty closure.
    public func replaceFirstViewController(
        with viewController: UIViewController,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        let viewControllers: [UIViewController] = [viewController] + self.viewControllers.removedFirst()
        
        dismissToRoot(animated: false) { [weak self] in
            guard let self else { return }
            setPresentedViewControllers(
                viewControllers,
                animated: animated,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                completion: completion
            )
        }
    }
    
    /// Inserts a view controller at a specific position in the stack of presented view controllers.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to insert.
    ///   - index: The position in the stack where the view controller should be inserted.
    ///   - animated: Whether to animate the presentation. Default is `true`.
    ///   - completion: A closure to be called after the presentation finishes. Default is an empty closure.
    open func insert(
        _ viewController: UIViewController,
        at index: Int,
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        let viewControllers = self.viewControllers.inserted(viewController, at: index)
        dismissToRoot(animated: false) { [weak self] in
            guard let self else { return }
            setPresentedViewControllers(
                viewControllers,
                animated: animated,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                completion: completion
            )
        }
    }
    
    /// Presents an array of view controllers sequentially.
    ///
    /// - Parameters:
    ///   - viewControllers: The array of view controllers to present.
    ///   - animated: Whether to animate the presentation. Default is `true`.
    ///   - presentationStyle: The modal presentation style to use. Default is `.automatic`.
    ///   - transitionStyle: The modal transition style to use. Default is `.coverVertical`.
    ///   - completion: A closure to be called after the presentation finishes. Default is an empty closure.
    public func setPresentedViewControllers(
        _ viewControllers: [UIViewController],
        animated: Bool = true,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: @escaping () -> Void = {}
    ) {
        dismissToRoot(animated: false) { [weak self] in
            guard let self else { return }
            present(
                contentsOf: viewControllers,
                animated: animated,
                presentationStyle: presentationStyle,
                transitionStyle: transitionStyle,
                completion: completion
            )
        }
    }
    
    /// Presents a view controller with specified sheet presentation options.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - detents: An array of detents specifying the height options for the sheet.
    ///   - selectedDetentIdentifier: The identifier of the initially selected detent. Default is `.large`.
    ///   - grabberVisible: Whether the grabber is visible. Default is `false`.
    ///   - cornerRadius: The corner radius of the sheet. Default is `nil`.
    ///   - scrollingExpandsWhenScrolledToEdge: Whether scrolling expands the sheet to the edge. Default is `true`.
    ///   - largestUndimmedDetentIdentifier: The largest detent that does not dim the background. Default is `nil`.
    ///   - animated: Whether to animate the presentation. Default is `true`.
    ///   - completion: A closure to be called after the presentation finishes. Default is an empty closure.
    @available(iOS 15.0, *)
    public func present(
        _ viewController: UIViewController,
        detents: [UISheetPresentationController.Detent],
        selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier = .large,
        grabberVisible: Bool = false,
        cornerRadius: CGFloat? = nil,
        scrollingExpandsWhenScrolledToEdge: Bool = true,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = detents
            sheet.selectedDetentIdentifier = selectedDetentIdentifier
            sheet.prefersGrabberVisible = grabberVisible
            sheet.preferredCornerRadius = cornerRadius
            sheet.prefersScrollingExpandsWhenScrolledToEdge = scrollingExpandsWhenScrolledToEdge
            sheet.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        }
        present(
            viewController,
            animated: animated,
            presentationStyle: .automatic,
            completion: completion
        )
    }
    
    /// Sets the selected detent for the sheet presentation controller.
    ///
    /// - Parameters:
    ///   - identifier: The identifier of the detent to select.
    ///   - animated: Whether to animate the change. Default is `true`.
    @available(iOS 15.0, *)
    open func sheetSelectedDetent(_ identifier: UISheetPresentationController.Detent.Identifier, animated: Bool = true) {
        guard let sheet = sheetPresentationController else {
            return logError("Failed to get sheetPresentationController for the presented View Controller")
        }
        
        if animated {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = identifier
            }
        } else {
            sheet.selectedDetentIdentifier = identifier
        }
    }
    
    /// Sets the detents for the sheet presentation controller.
    ///
    /// - Parameters:
    ///   - detents: The array of detents to set.
    ///   - animated: Whether to animate the change. Default is `true`.
    @available(iOS 15.0, *)
    open func sheetDetents(_ detents: [UISheetPresentationController.Detent], animated: Bool = true) {
        guard let sheet = sheetPresentationController else {
            return logError("Failed to get sheetPresentationController for the presented View Controller")
        }
        if animated {
            sheet.animateChanges {
                sheet.detents = detents
            }
        } else {
            sheet.detents = detents
        }
    }
    
    /// Sets whether the grabber is visible for the sheet presentation controller.
    ///
    /// - Parameter visible: Whether the grabber is visible. Default is `true`.
    @available(iOS 15.0, *)
    open func sheetPrefersGrabberVisible(_ visible: Bool = true) {
        guard let sheet = sheetPresentationController else {
            return logError("Failed to get sheetPresentationController for the presented View Controller")
        }
        
        sheet.prefersGrabberVisible = visible
    }
    
    /// Sets the corner radius for the sheet presentation controller.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius to set.
    ///   - animated: Whether to animate the change. Default is `true`.
    @available(iOS 15.0, *)
    open func sheetCornerRadius(_ cornerRadius: CGFloat, animated: Bool = true) {
        guard let sheet = sheetPresentationController else {
            return logError("Failed to get sheetPresentationController for the presented View Controller")
        }
        
        if animated {
            sheet.animateChanges {
                sheet.preferredCornerRadius = cornerRadius
            }
        } else {
            sheet.preferredCornerRadius = cornerRadius
        }
    }
    
    /// Sets whether scrolling expands the sheet to the edge for the sheet presentation controller.
    ///
    /// - Parameter preferred: Whether scrolling expands the sheet to the edge. Default is `true`.
    @available(iOS 15.0, *)
    open func sheetPrefersScrollingExpandsWhenScrolledToEdge(_ preferred: Bool = true) {
        guard let sheet = sheetPresentationController else {
            return logError("Failed to get sheetPresentationController for the presented View Controller")
        }
        
        sheet.prefersScrollingExpandsWhenScrolledToEdge = preferred
    }
    
    /// Sets the largest undimmed detent identifier for the sheet presentation controller.
    ///
    /// - Parameter identifier: The identifier of the largest undimmed detent. Default is `nil`.
    @available(iOS 15.0, *)
    open func sheetLargestUndimmedDetentIdentifier(_ identifier: UISheetPresentationController.Detent.Identifier? = nil) {
        guard let sheet = sheetPresentationController else {
            return logError("Failed to get sheetPresentationController for the presented View Controller")
        }
        
        sheet.largestUndimmedDetentIdentifier = identifier
    }
    
    @available(iOS 14.0, *)
    private func logError(_ message: String) {
        Logger(subsystem: "Coordinator.PresentationRouter", category: "Presentation").error("\(message)")
        delegate?.didEncounterError(NSError(domain: "PresentationRouter", code: 1, userInfo: [NSLocalizedDescriptionKey: message]))
    }
    
    /// Presents a view controller as a popover from a specified source view.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to present as a popover.
    ///   - sourceView: The view from which the popover will originate.
    ///   - contentSize: The preferred content size for the popover.
    ///   - alwaysPopUp: A Boolean value that determines whether the popover should always pop up. Default is `true`.
    ///   - arrowDirection: The direction of the popover arrow. Default is `.any`.
    ///   - animated: A Boolean value that determines whether the presentation should be animated. Default is `true`.
    ///   - completion: A closure to be called after the presentation completes. Default is an empty closure.
    public func presentPopOver(
        _ viewController: UIViewController,
        sourceView: UIView,
        preferredContentSize contentSize: CGSize,
        alwaysPopUp: Bool = true,
        arrowDirection: UIPopoverArrowDirection = .any,
        animated: Bool = true,
        completion: @escaping () -> Void = {}
    ) {
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = contentSize
        
        if alwaysPopUp, let presentationController = viewController.presentationController {
            presentationController.delegate = presentedViewController
        }
        
        presentedViewController.present(viewController, animated: animated, completion: completion)
        if let pop = viewController.popoverPresentationController {
            pop.sourceView = sourceView
            pop.sourceRect = sourceView.bounds
            pop.permittedArrowDirections = arrowDirection
        }
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
