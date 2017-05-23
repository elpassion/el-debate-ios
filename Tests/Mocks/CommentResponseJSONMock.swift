//
//  CommentResponseJSONMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 22/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Foundation

class CommentResponseJSONMock: JSONResponseProviding {
    
    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: ["status" : "comment_created"], error: nil)
        completionHandler(apiResponse)
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }
    
}

class CommentResponseErrorMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let error = RequestError.apiError(statusCode: 404)
        let apiResponse = ApiResponse(json: ["error" : "debate_not_found"], error: error)
        completionHandler(apiResponse)
    }
    
    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }
    
}
