//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit

public protocol PinFormValidating {

    func validate(username: String, pinCode: String) -> Promise<PinFormData>

}

public class PinFormValidator: PinFormValidating {

    private let usernameValidator: AnyValidator<String?>
    private let pinCodeValidator: AnyValidator<String?>

    public init(usernameValidator: AnyValidator<String?>, pinCodeValidator: AnyValidator<String?>) {
        self.usernameValidator = usernameValidator
        self.pinCodeValidator = pinCodeValidator
    }

    public func validate(username: String, pinCode: String) -> Promise<PinFormData> {
        return Promise { fullfill, reject in
            do {
                try usernameValidator.validate(username)
                try pinCodeValidator.validate(pinCode)

                fullfill(PinFormData(pin: pinCode, username: username))
            } catch let error {
                reject(error)
            }
        }
    }

}
