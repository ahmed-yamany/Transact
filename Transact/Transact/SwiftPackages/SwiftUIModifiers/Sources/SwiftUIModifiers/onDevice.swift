//
//  onDevice.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func iOS(_ modifer: (Self) -> some View) -> some View {
        applyModifierIfNeeded(modifer, for: .phone)
    }
    
    @ViewBuilder
    func iPadOS(_ modifer: (Self) -> some View) -> some View {
        applyModifierIfNeeded(modifer, for: .pad)
    }
    
    @ViewBuilder
    func macOS(_ modifer: (Self) -> some View) -> some View {
        applyModifierIfNeeded(modifer, for: .mac)
    }
    
    @ViewBuilder
    func tvOS(_ modifer: (Self) -> some View) -> some View {
        applyModifierIfNeeded(modifer, for: .tv)
    }
    
    func carPlay(_ modifer: (Self) -> some View) -> some View {
        return applyModifierIfNeeded(modifer, for: .carPlay)
    }
    
    @available(iOS 17.0, *)
    @ViewBuilder
    func vision(_ modifer: (Self) -> some View) -> some View {
        applyModifierIfNeeded(modifer, for: .vision)
    }
    
    @ViewBuilder
    private func applyModifierIfNeeded(_ modifer: (Self) -> some View, for idiom: UIUserInterfaceIdiom) -> some View {
        onCondition(UIDevice.current.userInterfaceIdiom == idiom, modifer)
    }
}
