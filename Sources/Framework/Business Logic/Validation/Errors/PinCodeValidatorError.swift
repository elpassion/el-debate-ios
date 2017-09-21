import Foundation

public enum PinCodeValidatorError: Error {

    case missing
    case tooLong
    case tooShort
    case invalidCharacter(character: String)

}

extension PinCodeValidatorError: AlertPresentableError {

    public var errorMessage: String {
        switch self {
        case .missing:
            return "The PIN code is required"
        case .tooLong:
            return "The PIN code should contain no more than 5 characters"
        case .tooShort:
            return "The PIN code should contain no less than 5 characters"
        case let .invalidCharacter(character):
            return "The PIN code contains invalid character: \(character)"
        }
    }

}
