//
//  SignupService.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import HTTPClient
import Signup

struct SignupService: SignupServiceInterface {
    let client: HTTPClient

    func signup(_ request: SignupRequestModel) async throws -> SignupResponseModel {
        SignupResponseModel(
            phoneNumber: request.phoneNumber,
            otpCodeExpires: 180,
            otpLenght: 4
        )
    }
}
