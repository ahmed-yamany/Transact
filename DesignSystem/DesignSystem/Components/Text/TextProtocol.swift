//
//  TextProtocol.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 12/11/2024.
//
import SwiftUI

public protocol TextProtocol: View {
    var text: Text { get }
    init(_ text: Text)
}

public extension TextProtocol {
    init(_ text: String) {
        self.init(Text(text))
    }

    init(_ attributedString: AttributedString) {
        self.init(Text(attributedString))
    }
}
