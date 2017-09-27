import ELDebateFramework
import Nimble
import Quick

// swiftlint:disable function_body_length

internal class PinFormValidatorSpec: QuickSpec {

    override func spec() {
        describe("PinFormValidator") {
            var usernameValidator: OptionalStringValidatorMock!
            var pinCodeValidator: OptionalStringValidatorMock!
            var sut: PinFormValidator!

            beforeEach {
                usernameValidator = OptionalStringValidatorMock()
                pinCodeValidator = OptionalStringValidatorMock()
                sut = PinFormValidator(usernameValidator: AnyValidator(usernameValidator),
                                       pinCodeValidator: AnyValidator(pinCodeValidator))
            }

            describe("validate") {
                it("should invoke validators with correct parameters") {
                    _ = sut.validate(username: "username", pinCode: "pinCode")

                    expect(usernameValidator.receivedValue) == "username"
                    expect(pinCodeValidator.receivedValue) == "pinCode"
                }

                context("when username validation fails") {
                    beforeEach {
                        usernameValidator.error = UsernameValidatorError.missing
                    }

                    it("should rethrow the error") {
                        var caughtError = false

                        _ = sut.validate(username: "username", pinCode: "pinCode")
                            .catch { error in
                                if case UsernameValidatorError.missing = error {
                                    caughtError = true
                                }
                            }

                        expect(caughtError).toEventually(beTrue())
                    }
                }

                context("when pin code validation fails") {
                    beforeEach {
                        pinCodeValidator.error = PinCodeValidatorError.missing
                    }

                    it("should rethrow the error") {
                        var caughtError = false

                        _ = sut.validate(username: "username", pinCode: "pinCode")
                            .catch { error in
                                if case PinCodeValidatorError.missing = error {
                                    caughtError = true
                                }
                            }

                        expect(caughtError).toEventually(beTrue())
                    }
                }

                context("when validation succeeds") {
                    it("should return validated data") {
                        var formData: LoginCredentials?

                        _ = sut.validate(username: "username", pinCode: "pinCode")
                            .then {
                                formData = $0
                            }

                        expect(formData?.username).toEventually(equal("username"))
                        expect(formData?.pin).toEventually(equal("pinCode"))
                    }
                }
            }
        }
    }

}
