//
//  VoteResponseJSONMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Foundation

class VoteResponseJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: "", error: nil)
        completionHandler(apiResponse)

    }
    
}

class VoteResponseErrorMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let error = RequestError.apiError(statusCode: 404)
        let apiResponse = ApiResponse(json: ["error" : "debate_not_found"], error: error)
        completionHandler(apiResponse)
    }
    
}
