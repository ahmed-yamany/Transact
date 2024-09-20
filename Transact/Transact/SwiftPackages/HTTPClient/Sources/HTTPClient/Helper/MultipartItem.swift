//
//  MultipartItem.swift
//
//
//  Created by Ahmed Fathy on 19/11/2023.
//

import Foundation

public struct MultipartItem {
    public let objectDic: Parameters
    public let boundary: String
    public let type: MimeType

    public init(boundary: String, objectDic: Parameters, type: MimeType = .jpeg) {
        self.boundary = boundary
        self.objectDic = objectDic
        self.type = type
    }
}
