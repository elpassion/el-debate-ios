@testable import ELDebateFramework

class AuthTokenStorageStub: AuthTokenStoring {

    var hasTokenReturnValue = false

    var getTokenPinCode: String?
    var getTokenReturnValue: String?

    var lastSavedPin: String?
    var lastSavedToken: String?

    var lastResetPin: String?

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

    func resetToken(forPinCode pinCode: String) {
        lastResetPin = pinCode
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

    func resetToken(forPinCode pinCode: String) {

    }

}
