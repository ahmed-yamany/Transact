//
//  UIImage+to.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

 public extension Array where Element == UIImage {
    func pngData() -> [Data] {
        // swiftlint: disable force_unwrapping
        map { $0.pngData() }.filter { $0 != nil }.map { $0! }
        // swiftlint: enable force_unwrapping
    }
    func jpgData(compressionQuality: CGFloat) -> [Data] {
        // swiftlint: disable force_unwrapping
        map { $0.jpegData(compressionQuality: compressionQuality) }.filter { $0 != nil }.map { $0! }
        // swiftlint: enable force_unwrapping
    }
}

public extension Array where Element == Data {
    func  toUIImages() -> [UIImage] {
        // swiftlint: disable force_unwrapping
        map { UIImage(data: $0) }.filter { $0 != nil }.map { $0! }
        // swiftlint: enable force_unwrapping
    }
}

@available(iOS 16.0, *)
public extension Image {
    @MainActor
    func uiImage() -> UIImage? {
        return ImageRenderer(content: self).uiImage
    }
}
