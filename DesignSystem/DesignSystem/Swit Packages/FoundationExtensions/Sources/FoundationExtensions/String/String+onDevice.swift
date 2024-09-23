//
//  String+onDevice.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//
#if canImport(UIKit)
import UIKit

public extension String {
    static func onDevice(
        iOS: String = "",
        iPad: String = "",
        mac: String = "",
        tv: String = "",
        carPlay: String = "",
        vision: String = ""
    ) -> String {
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
