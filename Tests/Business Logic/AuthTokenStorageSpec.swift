//
//  KeychainStorageSpec.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class AuthTokenStorageSpec: QuickSpec {

    override func spec() {
        var sut: AuthTokenStorage!

        describe("AuthTokenStorage") {
            beforeEach {
                sut = AuthTokenStorage(keychain: KeychainMock())
            }

            describe("saveToken") {
                context("the authToken was not saved before") {
                    it("saves the value") {
                        do {
                            try sut.save(token: "token_value", forPinCode: "12345")
                            expect(sut.getToken(forPinCode: "12345")) == "token_value"
                        } catch {
                            fatalError("Error saving token")
                        }
                    }
                }
            }

            describe("hasToken") {
                context("the authToken value is there") {
                    beforeEach {
                        do {
                            try sut.save(token: "token_value", forPinCode: "12345")
                        } catch {
                            fatalError("Error saving token")
                        }
                    }

                    it("returns true for the matching pin code") {
                        expect(sut.hasToken(forPinCode: "12345")).to(beTrue())
                    }

                    it("returns false for different pin code") {
                        expect(sut.hasToken(forPinCode: "67890")).to(beFalse())
                    }
                }
            }

            describe("getToken") {
                context("the authToken value is there") {
                    beforeEach {
                        do {
                            try sut.save(token: "token_value", forPinCode: "12345")
                        } catch {
                            fatalError("Error saving token")
                        }
                    }

                    it("returns the authToken for the matching pin code") {
                        expect(sut.getToken(forPinCode: "12345")) == "token_value"
                    }

                    it("does not return authToken for different pin code") {
                        expect(sut.getToken(forPinCode: "67890")).to(beNil())
                    }
                }
            }
        }
    }

}
