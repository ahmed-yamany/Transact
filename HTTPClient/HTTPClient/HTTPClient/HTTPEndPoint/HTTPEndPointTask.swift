//
//  HTTPEndPointTask.swift
//
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

public enum HTTPEndPointTask {
    case plain
    case body(Encodable)
    case query([String: Any])
    case bodyWithQuery((body: Encodable, query: [String: Any]))
    case multipart(multipart: [MultipartItem])
    case multipartWithQuery((multipart: [MultipartItem], query: [String: Any]))
}
