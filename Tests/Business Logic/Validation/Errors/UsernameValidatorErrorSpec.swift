//
// Created by Jakub Turek on 18.06.2017.
// Copyright (c) 2017 EL Passion. All rights reserved.
//

import ELDebateFramework
import Nimble
import Quick

internal class UsernameValidatorErrorSpec: QuickSpec {

    override func spec() {
        describe("UsernameValidatorError") {
            var sut: UsernameValidatorError!

            describe("missing") {
                beforeEach {
                    sut = .missing
                }

                it("should return proper error message") {
                    let error = sut.errorMessage

                    expect(error) == "The username is required"
                }
            }
        }
    }

}
