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

    // swiftlint:disable function_body_length
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

                    expect(result?.topic) == "debate_topic"
                    expect(result?.positiveAnswer).notTo(beNil())
                    expect(result?.neutralAnswer).notTo(beNil())
                    expect(result?.negativeAnswer).notTo(beNil())
                    expect(result?.positiveAnswer.identifier) == 122
                    expect(result?.negativeAnswer.identifier) == 123
                    expect(result?.neutralAnswer.identifier) == 124
                }

                it("should throw deserialization error if response is not a dictionary") {
                    expect { try deserializer.deserialize(json: "hello") }.to(throwError())
                }

                it("should throw deserialization error if topic is not in a dictionary") {
                    let response: Any? = [
                        "answers": [
                            "positive": ["id": 122, "value": "yes"],
                            "negative": ["id": 123, "value": "no"],
                            "neutral": ["id": 124, "value": "maybe"]
                        ]
                    ]

                    expect { try deserializer.deserialize(json: response) }.to(throwError())
                }

                it("should throw deserialization error if positive answer is not in a dictionary") {
                    let response: Any? = [
                        "topic": "Test topic",
                        "answers": [
                            "negative": ["id": 123, "value": "no"],
                            "neutral": ["id": 124, "value": "maybe"]
                        ]
                    ]

                    let error = errorMessage(deserializer: deserializer, json: response)

                    expect(error) == "Response does not contain positive answer data"
                }

                it("should throw deserialization error if negative answer is not in a dictionary") {
                    let response: Any? = [
                        "topic": "Test topic",
                        "answers": [
                            "positive": ["id": 123, "value": "yes"],
                            "neutral": ["id": 124, "value": "neutral"]
                        ]
                    ]

                    let error = errorMessage(deserializer: deserializer, json: response)

                    expect(error) == "Response does not contain negative answer data"
                }

                it("should throw deserialization error if neutral answer is not in a dictionary") {
                    let response: Any? = [
                        "topic": "Test topic",
                        "answers": [
                            "positive": ["id": 123, "value": "yes"],
                            "negative": ["id": 124, "value": "no"]
                        ]
                    ]

                    let error = errorMessage(deserializer: deserializer, json: response)

                    expect(error) == "Response does not contain neutral answer data"
                }
            }
        }
    }

}

private func errorMessage(deserializer: DebateDeserializer, json: Any?) -> String? {
    var errorMessage: String?

    do {
        _ = try deserializer.deserialize(json: json)
    } catch let RequestError.deserializationError(error) {
        errorMessage = error
    } catch { }

    return errorMessage
}
