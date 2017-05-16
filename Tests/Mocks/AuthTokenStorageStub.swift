//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate

class AuthTokenStorageStub: AuthTokenStoring {

    var hasTokenReturnValue = false

    var getTokenPinCode: String?
    var getTokenReturnValue: String?

    var lastSavedPin: String?
    var lastSavedToken: String?

    func hasToken(forPinCode pinCode: String) -> Bool {
        return hasTokenReturnValue
    }

    func getToken(forPinCode pinCode: String) -> String? {
        getTokenPinCode = pinCode

        return getTokenReturnValue
    }

    func save(token authToken: String, forPinCode pinCode: String) throws {
        lastSavedPin = pinCode
        lastSavedToken = authToken
    }

}

class ThrowingAuthTokenStorageStub: AuthTokenStoring {

    func hasToken(forPinCode pinCode: String) -> Bool {
        return false
    }

    func getToken(forPinCode pinCode: String) -> String? {
        return nil
    }

    func save(token authToken: String, forPinCode pinCode: String) throws {
        throw RequestError.apiError(statusCode: 555)
    }

}
