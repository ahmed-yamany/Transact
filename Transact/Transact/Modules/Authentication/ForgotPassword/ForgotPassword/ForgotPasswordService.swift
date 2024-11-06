//
//  ForgotPasswordService.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import ForgotPassword
import Foundation
import HTTPClient

struct ForgotPasswordService: ForgotPasswordServiceInterface {
    let client: HTTPClient

    func forgotPassword(_ request: ForgotPasswordRequestModel) async throws -> ForgotPasswordResponseModel {
        ForgotPasswordResponseModel(
            phoneNumber: request.phoneNumber,
            otpCodeExpires: 180,
            otpLenght: 4
        )
    }
}
