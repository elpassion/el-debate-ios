//
//  DebateDeserializerSpec.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class DebateDeserializerSpec: QuickSpec {

    override func spec() {
        describe("Debate deserializer") {
            var deserializer: DebateDeserializer!

            beforeEach {
                deserializer = DebateDeserializer(answerDeserializer: Deserializer(AnswerDeserializer()))
            }

            describe("deserializing") {
                it("should deserialize Debate correctly") {
                    let response: Any? = [
                        "topic": "debate_topic",
                        "answers": [
                            "positive": ["id": 122, "value": "yes"],
                            "negative": ["id": 123, "value": "no"],
                            "neutral": ["id": 124, "value": "maybe"]
                        ]
                    ]

                    let result: Debate? = try? deserializer.deserialize(json: response)

                    expect(result?.topic).to(equal("debate_topic"))
                    expect(result?.positiveAnswer).notTo(beNil())
                    expect(result?.neutralAnswer).notTo(beNil())
                    expect(result?.negativeAnswer).notTo(beNil())
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
