//
//  File.swift
//
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

public struct MultiPartWrapper {
    let items: [MultipartItem]

    public init(items: [MultipartItem]) {
        self.items = items
    }

    public func wrap() -> Data? {
        let lineBreak = "\r\n"
        var body = Data()

        for item in items {
            for (key, value) in item.objectDic {
                let boundary = item.boundary
                let contentType = item.type.rawValue
                let extensionType = item.type.extensionType

                if let value = value as? Data {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(UUID().uuidString).\(extensionType)\"\(lineBreak)")
                    body.append("Content-Type: \(contentType)" + lineBreak + lineBreak)
                    body.append(value)
                    body.append(lineBreak)

                } else if let value = value as? String {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                    body.append("\(value + lineBreak)")

                } else if let value = value as? NSNumber {
                    body.append("--\(item.boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                    body.append("\(value)" + lineBreak)
                }
                print("Key: \(key), value: \(value)")
            }
        }

        if let firstItem = items.first {
            body.append("--\(firstItem.boundary)--\(lineBreak)")
        }

        return body
    }
}
