import Foundation

public enum UsernameValidatorError: Error {

    case missing

}

extension UsernameValidatorError: AlertPresentableError {

    public var errorMessage: String {
        switch self {
        case .missing:
            return "The username is required"
        }
    }

}
