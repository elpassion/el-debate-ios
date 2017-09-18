import ELDebateFramework
import PromiseKit

internal class PinFormValidatorMock: PinFormValidating {

    var lastPin: String?
    var lastUsername: String?
    var error: Error?

    func validate(username: String, pinCode: String) -> Promise<LoginCredentials> {
        self.lastPin = pinCode
        self.lastUsername = username

        if let error = error {
            return Promise(error: error)
        } else {
            return Promise(value: LoginCredentials(pin: pinCode, username: username))
        }
    }

}
