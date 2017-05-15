//
//  LoginJSONResponseMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Foundation

class LoginResponseJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: ["auth_token" : "123456"], statusCode: 200)
        completionHandler(apiResponse)
    }

}

class LoginResponseErrorMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: ["error" : "auth_error"], statusCode: 401)

        completionHandler(apiResponse)
    }

}
