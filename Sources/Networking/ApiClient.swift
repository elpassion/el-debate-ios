//
//  ApiClient.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class ApiClient {

    private let requestExecutor: RequestExecuting

    init(requestExecutor: RequestExecuting = RequestExecutor()) {
        self.requestExecutor = requestExecutor
    }

    func login(pinCode: String, completionHandler: @escaping (String) -> Void) {
        let jsonResponse =  requestExecutor.post(
            url: "https://el-debate.herokuapp.com/api/login", body: ["code": pinCode]
        )

        jsonResponse.json { jsonResponse in
            guard let dict = jsonResponse as? [String: Any] else {
                fatalError("invalidResponse")
            }

            guard let authToken = dict["auth_token"] as? String else {
                fatalError("missing auth token in json response")
            }

            completionHandler(authToken)
        }
    }

}
