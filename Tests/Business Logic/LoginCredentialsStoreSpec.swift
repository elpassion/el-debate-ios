//
//  Created by Jakub Turek on 07.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick

class LoginCredentialsStoreSpec: QuickSpec {

    override func spec() {
        var userDefaults: UserDefaultsStoreMock!
        var sut: LoginCredentialsStore!

        describe("LoginCredentialsStore") {
            beforeEach {
                userDefaults = UserDefaultsStoreMock()
                sut = LoginCredentialsStore(userDefaults: userDefaults)
            }

            describe("lastCredentials") {
                describe("setter") {
                    it("should store serialized credentials to a dictionary") {
                        let credentials = LoginCredentials(pin: "PIN", username: "USER")

                        sut.lastCredentials = credentials

                        let storedValue = userDefaults.store["LastCredentials"] as? String
                        let noWhitespaceValue = storedValue?
                            .replacingOccurrences(of: "\n", with: "")
                            .replacingOccurrences(of: " ", with: "")

                        expect(noWhitespaceValue) == "{\"username\":\"USER\",\"pinCode\":\"PIN\"}"
                    }
                }

                describe("getter") {
                    it("should return nil if there is no value") {
                        userDefaults.store = [:]

                        let credentials = sut.lastCredentials

                        expect(credentials).to(beNil())
                    }

                    it("should return nil for malformed input") {
                        userDefaults.store = ["LastCredentials": "hello"]

                        let credentials = sut.lastCredentials

                        expect(credentials).to(beNil())
                    }

                    it("should return nil if there is no pinCode") {
                        userDefaults.store = ["LastCredentials": "{\"username\":\"ME\"}"]

                        let credentials = sut.lastCredentials

                        expect(credentials).to(beNil())
                    }

                    it("should return nil if there is no username") {
                        userDefaults.store = ["LastCredentials": "{\"pinCode\":\"123\"}"]

                        let credentials = sut.lastCredentials

                        expect(credentials).to(beNil())
                    }

                    it("should return deserialized value if present") {
                        userDefaults.store = ["LastCredentials": "{\"pinCode\":\"123\",\"username\":\"ME\"}"]

                        let credentials = sut.lastCredentials

                        expect(credentials?.pin) == "123"
                        expect(credentials?.username) == "ME"
                    }
                }
            }
        }
    }

}
