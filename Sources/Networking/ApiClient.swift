//
//  ApiClient.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

protocol APIProviding {

    func login(pinCode: String) -> Promise<String>
    func fetchDebate(authToken: String) -> Promise<Debate>
    func vote(authToken: String, answer: Answer) -> Promise<Answer>
    func comment(authToken: String, text: String) -> Promise<Bool>

}

class ApiClient: APIProviding {

    private let requestExecutor: RequestExecuting
    private let authTokenDeserializer: Deserializer<String>
    private let debateDeserializer: Deserializer<Debate>
    private let apiHost: String = "https://el-debate.herokuapp.com"

    init(requestExecutor: RequestExecuting,
         authTokenDeserializer: Deserializer<String>,
         debateDeserializer: Deserializer<Debate>) {
        self.requestExecutor = requestExecutor
        self.authTokenDeserializer = authTokenDeserializer
        self.debateDeserializer = debateDeserializer
    }

    func login(pinCode: String) -> Promise<String> {
        let jsonResponse = requestExecutor.post(
            url: "\(apiHost)/api/login",
            body: ["code": pinCode],
            headers: nil
        )

        return Promise(requestExecutor: jsonResponse.json, processor: { [weak self] apiResponse in
            try deserialize(response: apiResponse, with: self?.authTokenDeserializer)
        })
    }

    func fetchDebate(authToken: String) -> Promise<Debate> {
        let jsonResponse = requestExecutor.get(
            url: "\(apiHost)/api/debate",
            headers: ["Authorization": authToken]
        )

        return Promise(requestExecutor: jsonResponse.json, processor: { [weak self] apiResponse in
            try deserialize(response: apiResponse, with: self?.debateDeserializer)
        })
    }

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        let response = requestExecutor.post(
            url: "\(apiHost)/api/vote",
            body: ["id": answer.identifier],
            headers: ["Authorization": authToken]
        )

        return Promise(requestExecutor: response.maybeJson, processor: { _ in answer })
            .recover { error -> Promise<Answer> in
                if case let AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: code)) = error,
                    code == 429 {
                    return Promise(error: RequestError.throttling)
                } else {
                    return Promise(error: error)
                }
            }
    }

    func comment(authToken: String, text: String) -> Promise<Bool> {
        let response = requestExecutor.post(
            url: "\(apiHost)/api/comment",
            body: ["text": text],
            headers: ["Authorization": authToken]
        )

        return Promise(requestExecutor: response.maybeJson, processor: { _ in true })
    }

}

private func deserialize<T>(response: ApiResponse, with deserializer: Deserializer<T>?) throws -> T {
    guard let deserializer = deserializer else { throw RequestError.deallocatedClientError }
    return try deserializer.deserialize(json: response.json)
}
