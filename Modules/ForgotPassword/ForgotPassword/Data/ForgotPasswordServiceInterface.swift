//
//  ForgotPasswordServiceInterface.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public protocol ForgotPasswordServiceInterface {
    func forgotPassword(_ request: ForgotPasswordRequestModel) async throws -> ForgotPasswordResponseModel
}
