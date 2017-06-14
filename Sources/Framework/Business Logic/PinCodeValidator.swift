//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

public enum PinCodeValidatorError: Error {

    case invalidPin(reason: String)

}

public class PinCodeValidator: Validator {

    private let validLength: Int = 5

    public init() { }

    public func validate(_ value: String?) throws {
        guard let value = value, !value.isEmpty else {
            throw PinCodeValidatorError.invalidPin(reason: "The PIN code is required")
        }

        guard value.characters.count < (validLength + 1) else {
            throw PinCodeValidatorError.invalidPin(reason: "The PIN code is too long")
        }

        guard value.characters.count > (validLength - 1) else {
            throw PinCodeValidatorError.invalidPin(reason: "The PIN code is too short")
        }

        let validCharacters = CharacterSet.decimalDigits
        let firstInvalid = value.unicodeScalars.first { scalar in
            !validCharacters.contains(scalar)
        }

        if let firstInvalid = firstInvalid {
            throw PinCodeValidatorError.invalidPin(reason: "The PIN code contains invalid character: \(firstInvalid)")
        }
    }

}
