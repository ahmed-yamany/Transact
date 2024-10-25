//
//  RecursiveModifierApplier.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 16/10/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func recursiveModifierApplier<Modifier: ViewModifier, T: Hashable>(
        _ elements: Binding<[T]>,
        modifierBuilder: @escaping (T?) -> Modifier
    ) -> some View {
        modifier(RecursiveModifierApplier(elements, modifierBuilder: modifierBuilder))
    }
}

struct RecursiveModifierApplier<Modifier: ViewModifier, T: Hashable>: ViewModifier {
    @Binding var elements: [T]
    let currentElement: T?
    let modifierBuilder: (T?) -> Modifier

    init(_ elements: Binding<[T]>, currentElement: T? = nil, modifierBuilder: @escaping (T?) -> Modifier) {
        _elements = elements
        self.currentElement = currentElement
        self.modifierBuilder = modifierBuilder
    }

    func body(content: Content) -> some View {
        // Determine the next view to apply the modifier
        let nextElement = getNextElement()

        return applyModifierRecursively(content: content, nextElement: nextElement)
    }

    private func getNextElement() -> T? {
        guard !elements.isEmpty else { return nil }

        if currentElement == nil {
            return elements.first
        }

        if let currentElement = currentElement {
            return elements.nextElement(to: currentElement)
        }

        return nil
    }

    @ViewBuilder
    private func applyModifierRecursively(content: Content, nextElement: T?) -> some View {
        if let nextElement = nextElement {
            content
                .modifier(modifierBuilder(nextElement))
                .modifier(RecursiveModifierApplier($elements, currentElement: nextElement, modifierBuilder: modifierBuilder))
        } else {
            content
        }
    }
}

public extension Array where Element: Hashable {
    func nextElement(to element: Element) -> Element? {
        if let index = firstIndex(of: element), indices.contains(index + 1) {
            return self[index + 1]
        }
        return nil
    }
}
