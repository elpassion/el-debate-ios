//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import ELDebateFramework
import PromiseKit

internal class PinFormValidatorMock: PinFormValidating {

    var error: Error?

    func validate(username: String, pinCode: String) -> Promise<LoginCredentials> {
        if let error = error {
            return Promise(error: error)
        } else {
            return Promise(value: LoginCredentials(pin: pinCode, username: username))
        }
    }

}
