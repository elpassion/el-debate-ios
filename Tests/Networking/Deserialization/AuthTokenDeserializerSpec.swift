//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick

class AuthTokenDeserializerSpec: QuickSpec {

    override func spec() {
        describe("AuthTokenDeserializer") {
            var deserializer: AuthTokenDeserializer!

            beforeEach {
                deserializer = AuthTokenDeserializer()
            }

            describe("deserializing") {
                it("should deserialize auth token properly") {
                    let response: Any? = ["auth_token": "auth_token_value"]
                    let result = try? deserializer.deserialize(json: response)

                    expect(result) == "auth_token_value"
                }

                it("should throw deserialization error if response is not a dictionary") {
                    expect { try deserializer.deserialize(json: "hello") }.to(throwError())
                }

                it("should throw deserialization error if auth token is not in a dictionary") {
                    let response: Any? = ["not_an_auth_token": 12]

                    expect { try deserializer.deserialize(json: response) }.to(throwError())
                }
            }
        }
    }

}
