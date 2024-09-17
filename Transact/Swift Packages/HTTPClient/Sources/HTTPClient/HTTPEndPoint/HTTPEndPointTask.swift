//
//  HTTPEndPointTask.swift
//
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

public typealias Parameters = [String: Any]

public enum HTTPEndPointTask {
    case plain
    case body(Encodable)
    case query(Parameters)
    case bodyWithQuery((body: Encodable, query: Parameters))
    case multipart(multipart: [MultipartItem])
    case multipartWithQuery((multipart: [MultipartItem], query: Parameters))
}
