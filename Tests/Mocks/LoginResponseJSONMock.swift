@testable import ELDebateFramework
import Foundation

class LoginResponseJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(json: ["auth_token": "123456"], error: nil)
        completionHandler(apiResponse)
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }

}

class LoginResponseErrorMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let error = RequestError.apiError(statusCode: 401)
        let apiResponse = ApiResponse(json: ["error": "auth_error"], error: error)

        completionHandler(apiResponse)
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }

}
