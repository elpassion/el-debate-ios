//
//  AnswerDeserializerSpec.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 12/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class AnswerDeserializerSpec: QuickSpec {

    override func spec() {
        describe("Answer deserializer") {
            var deserializer: AnswerDeserializer!

            beforeEach {
                deserializer = AnswerDeserializer()
            }

            describe("deserializing") {
                it("should deserialize Answer correctly") {
                    let response: Any? = [
                        "id": 123,
                        "value": "uważam że tak"
                    ]

                    let result: Answer? = try? deserializer.deserialize(json: response)

                    expect(result?.identifier).to(equal(123))
                    expect(result?.value).to(equal("uważam że tak"))
                }

                it("should throw deserialization error if response is not a dictionary") {
                    expect { try deserializer.deserialize(json: "hello") }.to(throwError())
                }

                it("should throw deserialization error if correct properties are not in a dictionary") {
                    let response: Any? = ["not_an_auth_token": 12]

                    expect { try deserializer.deserialize(json: response) }.to(throwError())
                }
            }
        }
    }
}
