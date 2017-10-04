import ELDebateFramework
import PromiseKit

internal class PinFormValidatorMock: PinFormValidating {

    var lastPin: String?
    var error: Error?

    func validate(pinCode: String) -> Promise<LoginCredentials> {
        self.lastPin = pinCode

        if let error = error {
            return Promise(error: error)
        } else {
            return Promise(value: LoginCredentials(pin: pinCode))
        }
    }

}
