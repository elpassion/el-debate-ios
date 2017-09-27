import ELDebateFramework
import Nimble
import Quick

internal class PinCodeValidatorSpec: QuickSpec {

    override func spec() {
        describe("PinCodeValidator") {
            var sut: AnyValidator<String?>!

            beforeEach {
                sut = AnyValidator(PinCodeValidator())
            }

            describe("validate") {
                it("should throw a missing exception if pin is nil") {
                    expect { try sut.validate(nil) }.to(throwError(PinCodeValidatorError.missing))
                }

                it("should throw a missing exception if pin is an empty string") {
                    expect { try sut.validate("") }.to(throwError(PinCodeValidatorError.missing))
                }

                it("should throw a too short exception if pin is too short") {
                    let tooShortPin = "1234"

                    expect { try sut.validate(tooShortPin) }.to(throwError(PinCodeValidatorError.tooShort))
                }

                it("should throw a too long exception if pin is too long") {
                    let tooLongPin = "123456"

                    expect { try sut.validate(tooLongPin) }.to(throwError(PinCodeValidatorError.tooLong))
                }

                it("should throw an invalidCharacter exception if pin contains prohibited characters") {
                    let pinWithProhibitedCharacters = "123#5"

                    expect { try sut.validate(pinWithProhibitedCharacters) }.to(throwError(
                        PinCodeValidatorError.invalidCharacter(character: "#")))
                }

                it("should not throw an exception for a valid pin") {
                    let validPIN = "14582"

                    expect { try sut.validate(validPIN) }.toNot(throwError())
                }
            }
        }
    }

}
