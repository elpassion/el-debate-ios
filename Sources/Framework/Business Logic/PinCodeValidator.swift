//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

public enum PinCodeValidatorError: Error {

    case missing
    case tooLong
    case tooShort
    case invalidCharacter(character: String)

}

public class PinCodeValidator: Validator {

    private let validLength: Int = 5

    public init() {}

    public func validate(_ value: String?) throws {
        guard let value = value, !value.isEmpty else {
            throw PinCodeValidatorError.missing
        }

        let charactersCount = value.characters.count

        if charactersCount > validLength {
            throw PinCodeValidatorError.tooLong
        } else if charactersCount < validLength {
            throw PinCodeValidatorError.tooShort
        }

        let validCharacters = CharacterSet.decimalDigits
        let firstInvalid = value.unicodeScalars.first { scalar in
            !validCharacters.contains(scalar)
        }

        if let firstInvalid = firstInvalid {
            throw PinCodeValidatorError.invalidCharacter(character: "\(firstInvalid)")
        }
    }

}
