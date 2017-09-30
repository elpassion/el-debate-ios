import PromiseKit

public protocol PinFormValidating {

    func validate(pinCode: String) -> Promise<LoginCredentials>

}

public class PinFormValidator: PinFormValidating {

    private let pinCodeValidator: AnyValidator<String?>

    public init(pinCodeValidator: AnyValidator<String?>) {
        self.pinCodeValidator = pinCodeValidator
    }

    public func validate(pinCode: String) -> Promise<LoginCredentials> {
        return Promise { fullfill, reject in
            do {
                try pinCodeValidator.validate(pinCode)

                fullfill(LoginCredentials(pin: pinCode))
            } catch let error {
                reject(error)
            }
        }
    }

}
