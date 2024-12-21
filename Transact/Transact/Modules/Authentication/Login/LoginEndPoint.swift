//
//  LoginEndPoint.swift
//  Transact
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Foundation
import HTTPClient
import Login

struct LoginEndPoint: TransactHTTPEndpoint {
    let path: String = "login"
    let method: HTTPMethod = .post
    let task: HTTPEndPointTask
    let headers: [String: String]? = nil

    init(model: LoginModel) {
        task = .body(model)
    }
}

extension HTTPEndPoint where Self == AuthenticatedHTTPEndPointDecorator {
    static func login(_ model: LoginModel) async -> HTTPEndPoint {
        await .authenticated(LoginEndPoint(model: model))
    }
}
