//
//  DebateDeserializer.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class DebateDeserializer: Deserializing {
    let answerDeserializer: Deserializer<Answer>

    static func build() -> Deserializer<Debate> {
        return Deserializer(
            DebateDeserializer(
                answerDeserializer: Deserializer(AnswerDeserializer())
            )
        )
    }

    init(answerDeserializer: Deserializer<Answer>) {
        self.answerDeserializer = answerDeserializer
    }

    func deserialize(json: Any?) throws -> Debate {
        guard let dict = json as? [String: Any] else {
            throw RequestError.deserializationError(reason: "Response is not a dictionary")
        }

        guard let topic = dict["topic"] as? String else {
            throw RequestError.deserializationError(reason: "Response does not contain debate topic")
        }

        guard let answersData = dict["answers"] as? [String: [String: Any?]] else {
            throw RequestError.deserializationError(reason: "Response does not contain answers data")
        }

        var positiveAnswer: Answer?
        var neutralAnswer: Answer?
        var negativeAnswer: Answer?

        try answersData.forEach { answerTypeRaw, answerJSON in
            guard let answerType = AnswerType(rawValue: answerTypeRaw) else { return }

            switch answerType {
            case .positive:
                positiveAnswer = try answerDeserializer.deserialize(json: answerJSON)
            case .neutral:
                neutralAnswer = try answerDeserializer.deserialize(json: answerJSON)
            case .negative:
                negativeAnswer = try answerDeserializer.deserialize(json: answerJSON)
            }
        }

        guard let positive = positiveAnswer, let neutral = neutralAnswer, let negative = negativeAnswer else {
            throw RequestError.deserializationError(reason: "Response does not contain answers data")
        }

        return Debate(
            topic: topic,
            positiveAnswer: positive,
            neutralAnswer:  neutral,
            negativeAnswer: negative
        )
    }
}
