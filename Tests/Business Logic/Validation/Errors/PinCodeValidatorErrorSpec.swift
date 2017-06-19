//
// Created by Jakub Turek on 18.06.2017.
// Copyright (c) 2017 EL Passion. All rights reserved.
//

import ELDebateFramework
import Nimble
import Quick

internal class PinCodeValidatorErrorSpec: QuickSpec {

    override func spec() {
        describe("PinCodeValidatorError") {
            var sut: PinCodeValidatorError!

            describe("invalid character") {
                beforeEach {
                    sut = .invalidCharacter(character: "#")
                }

                it("should return proper error message") {
                    let error = sut.errorMessage

                    expect(error) == "The PIN code contains invalid character: #"
                }
            }

            describe("missing") {
                beforeEach {
                    sut = .missing
                }

                it("should return proper error message") {
                    let error = sut.errorMessage

                    expect(error) == "The PIN code is required"
                }
            }

            describe("too long") {
                beforeEach {
                    sut = .tooLong
                }

                it("should return proper error message") {
                    let error = sut.errorMessage

                    expect(error) == "The PIN code should contain no more than 5 characters"
                }
            }

            describe("too short") {
                beforeEach {
                    sut = .tooShort
                }

                it("should return proper error message") {
                    let error = sut.errorMessage

                    expect(error) == "The PIN code should contain no less than 5 characters"
                }
            }
        }
    }

}
