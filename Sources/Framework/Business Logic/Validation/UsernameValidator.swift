import Foundation

public class UsernameValidator: Validator {

    public init() {}

    public func validate(_ value: String?) throws {
        guard let value = value, !value.isEmpty else {
            throw UsernameValidatorError.missing
        }
    }

}
