//
//  VoteResponseJSONMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Foundation

class VoteResponseJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: "", error: nil)
        completionHandler(apiResponse)

    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }
    
}

class VoteResponseErrorMock: JSONResponseProviding {

    var errorJSON: Any = ["error": "debate_not_found"]
    var error: RequestError = RequestError.apiError(statusCode: 404)

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: errorJSON, error: error)
        completionHandler(apiResponse)
    }
    
    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: errorJSON, error: error)
        completionHandler(apiResponse)
    }
    
}
