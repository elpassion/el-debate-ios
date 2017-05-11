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

    func json(completionHandler: @escaping (Any?) -> Void) {
        completionHandler(["auth_token" : "123456"])
    }

}
