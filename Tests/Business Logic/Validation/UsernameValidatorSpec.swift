import ELDebateFramework
import Nimble
import Quick

internal class UsernameValidatorSpec: QuickSpec {

    override func spec() {
        describe("UsernameValidator") {
            var sut: AnyValidator<String?>!

            beforeEach {
                sut = AnyValidator(UsernameValidator())
            }

            describe("validate") {
                it("should throw a missing exception if username is nil") {
                    expect { try sut.validate(nil) }.to(throwError(UsernameValidatorError.missing))
                }

                it("should throw a missing exception if username is an empty string") {
                    expect { try sut.validate(nil) }.to(throwError(UsernameValidatorError.missing))
                }

                it("should not throw an error if username is given") {
                    expect { try sut.validate("username") }.toNot(throwError())
                }
            }
        }
    }

}
