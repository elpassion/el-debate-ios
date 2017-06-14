//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

public enum UsernameValidatorError: Error {

    case missing

}

public class UsernameValidator: Validator {

    public init() {}

    public func validate(_ value: String?) throws {
        guard let value = value, !value.isEmpty else {
            throw UsernameValidatorError.missing
        }
    }

}
