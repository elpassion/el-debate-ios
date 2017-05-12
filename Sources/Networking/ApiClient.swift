//
//  ApiClient.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol APIProviding: AutoMockable {

    func login(pinCode: String, completionHandler: @escaping (String?) -> Void)

}

class ApiClient: APIProviding {

    private let requestExecutor: RequestExecuting
    private let authTokenDeserializer: Deserializer<String>

    init(requestExecutor: RequestExecuting,
         authTokenDeserializer: Deserializer<String>) {
        self.requestExecutor = requestExecutor
        self.authTokenDeserializer = authTokenDeserializer
    }

    func login(pinCode: String, completionHandler: @escaping (String?) -> Void) {
        let jsonResponse =  requestExecutor.post(
            url: "https://el-debate.herokuapp.com/api/login", body: ["code": pinCode]
        )

        jsonResponse.json { [weak self] jsonResponse in
            guard let `self` = self else { return }
            completionHandler(try? self.authTokenDeserializer.deserialize(json: jsonResponse))
        }
    }

}
