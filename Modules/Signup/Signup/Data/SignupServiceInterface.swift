//
//  SignupServiceInterface.swift
//  Signup
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public protocol SignupServiceInterface {
    func signup(_ request: SignupRequestModel) async throws -> SignupResponseModel
}
