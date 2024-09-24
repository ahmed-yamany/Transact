//
//  UIImage+Color.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UIImage {
    /**
     Create an image of a solid color with the specified size.
     
     If the size is not provided, the default size is 1x1 pixel.
     
     Example usage:
     
     ```swift
     let redImage = UIImage(color: UIColor.red, size: CGSize(width: 50, height: 50))
     ```
     
     - Parameters:
     - color: The color to fill the image with.
     - size: The size of the resulting image.
     
     - Returns: An instance of `UIImage` filled with the specified color, or `nil` if the image creation fails.
     */
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
#endif
