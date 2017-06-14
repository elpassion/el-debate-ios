//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

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
                it("should throw an exception if pin is nil") {
                    expect { try sut.validate(nil) }.to(throwError(
                        PinCodeValidatorError.invalidPin(reason: "The PIN code is required")))
                }

                it("should throw an exception if pin is an empty string") {
                    expect { try sut.validate("") }.to(throwError(
                        PinCodeValidatorError.invalidPin(reason: "The PIN code is required")))
                }

                it("should throw an exception if pin is too short") {
                    let tooShortPin = "1234"

                    expect { try sut.validate(tooShortPin) }.to(throwError(
                        PinCodeValidatorError.invalidPin(reason: "The PIN code is too short")))
                }

                it("should throw an exception if pin is too long") {
                    let tooLongPin = "123456"

                    expect { try sut.validate(tooLongPin) }.to(throwError(
                        PinCodeValidatorError.invalidPin(reason: "The PIN code is too long")))
                }

                it("should throw an exception if pin contains prohibited characters") {
                    let pinWithProhibitedCharacters = "123#5"

                    expect { try sut.validate(pinWithProhibitedCharacters) }.to(throwError(
                        PinCodeValidatorError.invalidPin(reason: "The PIN code contains invalid character: #")))
                }

                it("should not throw an exception for a valid pin") {
                    let validPIN = "14582"

                    expect { try sut.validate(validPIN) }.toNot(throwError())
                }
            }
        }
    }

}
