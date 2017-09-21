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
