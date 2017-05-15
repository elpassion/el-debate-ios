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
                            try sut.saveToken("token_value")
                            expect(sut.getToken()).to(equal("token_value"))
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
                            try sut.saveToken("token_value")
                        } catch {
                            fatalError("Error saving token")
                        }
                    }

                    it("returns true") {
                        expect(sut.hasToken()).to(equal(true))
                    }
                }

                context("the authToken value is not there") {
                    it("returns false") {
                        expect(sut.hasToken()).to(equal(false))
                    }
                }
            }

            describe("getToken") {
                context("the authToken value is there") {
                    beforeEach {
                        do {
                            try sut.saveToken("token_value")
                        } catch {
                            fatalError("Error saving token")
                        }
                    }

                    it("returns the authToken") {
                        expect(sut.getToken()).to(equal("token_value"))
                    }
                }

                context("the authToken value is not there") {
                    it("returns nil") {
                        expect(sut.getToken()).to(beNil())
                    }
                }
            }
        }
    }
}
