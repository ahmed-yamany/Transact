//
//  File.swift
//
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation
import HTTPClient

public extension URLComponents {
    init?(endpoint: HTTPEndPoint) {
        self.init(string: endpoint.url)
        
        if case let .query(queries) = endpoint.task {
            queryItems = queries.map(QueryItemsMapper.map)
            
        } else if case let .bodyWithQuery(bodyWithQuery) = endpoint.task {
            queryItems = bodyWithQuery.query.map(QueryItemsMapper.map)
            
        } else if case let .multipartWithQuery(multipartWithQuery) = endpoint.task {
            queryItems = multipartWithQuery.query.map(QueryItemsMapper.map)
        }
    }
}
