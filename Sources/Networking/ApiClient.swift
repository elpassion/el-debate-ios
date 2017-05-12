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
    func fetchDebate(authToken: String, completionHandler: @escaping (Debate?) -> Void)

}

class ApiClient: APIProviding {

    private let requestExecutor: RequestExecuting
    private let authTokenDeserializer: Deserializer<String>
    private let debateDeserializer: Deserializer<Debate>
    private let apiHost = "https://el-debate.herokuapp.com"

    init(requestExecutor: RequestExecuting,
         authTokenDeserializer: Deserializer<String>,
         debateDeserializer: Deserializer<Debate>) {
        self.requestExecutor = requestExecutor
        self.authTokenDeserializer = authTokenDeserializer
        self.debateDeserializer = debateDeserializer
    }

    func login(pinCode: String, completionHandler: @escaping (String?) -> Void) {
        let jsonResponse = requestExecutor.post(
            url: "\(apiHost)/api/login", body: ["code": pinCode]
        )

        jsonResponse.json { [weak self] jsonData in
            guard let `self` = self else { return }
            completionHandler(try? self.authTokenDeserializer.deserialize(json: jsonData))
        }
    }

    func fetchDebate(authToken: String, completionHandler: @escaping (Debate?) -> Void) {
        let jsonResponse =  requestExecutor.get(
            url: "\(apiHost)/api/debate", headers: ["Authorization": authToken]
        )

        jsonResponse.json { [weak self] jsonData in
            guard let `self` = self else { return }
            completionHandler(try? self.debateDeserializer.deserialize(json: jsonData))
        }
    }
}
