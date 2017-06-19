//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import ELDebateFramework

class OptionalStringValidatorMock: Validator {

    var receivedValue: String?
    var error: Error?

    func validate(_ value: String?) throws {
        receivedValue = value

        if let error = error {
            throw error
        }
    }

}
