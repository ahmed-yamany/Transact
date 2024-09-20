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
                if let value = value as? Data {
                    body.append("--\(item.boundary + lineBreak)")
                    body.append("Content-Disposition: form-data;"
                        + "name=\"\(key)\"; "
                        + "filename=\"\(UUID().uuidString).\(item.type.extensionType)\"\(lineBreak)")
                    body.append("Content-Type: \(item.type.rawValue)" + lineBreak + lineBreak)
                    body.append(value)
                    body.append(lineBreak)

                } else if let value = value as? String {
                    body.append("--\(item.boundary + lineBreak)")
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

        body.append("--\(items.first?.boundary ?? "")--\(lineBreak)")

        return body
    }
}
