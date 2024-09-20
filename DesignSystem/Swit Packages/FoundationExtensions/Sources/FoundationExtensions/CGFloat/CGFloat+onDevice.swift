//
//  CGFloat+onDevice.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if canImport(UIKit)
import UIKit

public extension CGFloat {
    static func onDevice(
        iOS: CGFloat = 0,
        iPad: CGFloat = 0,
        mac: CGFloat = 0,
        tv: CGFloat = 0,
        carPlay: CGFloat = 0,
        vision: CGFloat = 0
    ) -> CGFloat {
        let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        
        if userInterfaceIdiom == .phone {
            return iOS
        } else if userInterfaceIdiom == .pad {
            return iPad
        } else if userInterfaceIdiom == .carPlay {
            return carPlay
        } else if userInterfaceIdiom == .tv {
            return tv
        } else if userInterfaceIdiom == .mac {
            return mac
        }
        
        if #available(iOS 17.0, *), userInterfaceIdiom == .vision {
            return vision
        }
        
        return iOS
    }
}
#endif
