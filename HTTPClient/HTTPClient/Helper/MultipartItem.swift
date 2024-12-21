//
//  MultipartItem.swift
//
//
//  Created by Ahmed Fathy on 19/11/2023.
//

import Foundation

public struct MultipartItem {
    public let objectDic: [String: Any]
    public let boundary: String
    public let type: MimeType

    public init(boundary: String, objectDic: [String: Any], type: MimeType = .jpeg) {
        self.boundary = boundary
        self.objectDic = objectDic
        self.type = type
    }
}
