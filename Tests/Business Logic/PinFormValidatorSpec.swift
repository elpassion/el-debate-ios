import ELDebateFramework
import Nimble
import Quick

// swiftlint:disable function_body_length

internal class PinFormValidatorSpec: QuickSpec {

    override func spec() {
        describe("PinFormValidator") {
            var pinCodeValidator: OptionalStringValidatorMock!
            var sut: PinFormValidator!

            beforeEach {
                pinCodeValidator = OptionalStringValidatorMock()
                sut = PinFormValidator(pinCodeValidator: AnyValidator(pinCodeValidator))
            }

            describe("validate") {
                it("should invoke validators with correct parameters") {
                    _ = sut.validate(pinCode: "pinCode")

                    expect(pinCodeValidator.receivedValue) == "pinCode"
                }

                context("when pin code validation fails") {
                    beforeEach {
                        pinCodeValidator.error = PinCodeValidatorError.missing
                    }

                    it("should rethrow the error") {
                        var caughtError = false

                        _ = sut.validate(pinCode: "pinCode")
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

                        _ = sut.validate(pinCode: "pinCode")
                            .then {
                                formData = $0
                            }

                        expect(formData?.pin).toEventually(equal("pinCode"))
                    }
                }
            }
        }
    }

}
