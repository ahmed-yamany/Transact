//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation
import HTTPClient

public extension URLRequest {
    init(endpoint: HTTPEndPoint) {
        guard let urlComponents = URLComponents(endpoint: endpoint), let url = urlComponents.url else {
            self.init(url: URL(fileURLWithPath: ""))
            return
        }
        
        self.init(url: url, timeoutInterval: endpoint.timeInterval)
        
        self.httpMethod = endpoint.method.rawValue
        
        addHeaders(endpoint.headers)
        
        if case let .body(body) = endpoint.task {
            httpBody = body.prepareBody()
            
        } else if case let .bodyWithQuery(bodyWithQuery) = endpoint.task {
            httpBody = bodyWithQuery.body.prepareBody()
            
        } else if case let .multipart(multipart) = endpoint.task {
            httpBody = MultiPartWrapper(items: multipart).wrap()
            
        } else if case let .multipartWithQuery(multipartWithQuery) = endpoint.task {
            httpBody = MultiPartWrapper(items: multipartWithQuery.multipart).wrap()
        }
                    
    }
    
    private mutating func addHeaders(_ headers: [String: String]?) {
        headers?.forEach({ key, value in
            addValue(value, forHTTPHeaderField: key)
        })
    }
}
