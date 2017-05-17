//
//  DebateDeserializer.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class DebateDeserializer: Deserializing {

    private let answerDeserializer: Deserializer<Answer>

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

        let parsedAnswers = try answersData.mapDictionary { (type, answerJSON) in
            return (type, answerJSON.merge(["answer_type": type]))
        }.map { (_, answerJSON) in
            try answerDeserializer.deserialize(json: answerJSON)
        }

        return Debate(topic: topic,
                      positiveAnswer: answer(from: parsedAnswers, ofType: .positive),
                      neutralAnswer: answer(from: parsedAnswers, ofType: .neutral),
                      negativeAnswer: answer(from: parsedAnswers, ofType: .negative))
    }

    private func answer(from answers: [Answer], ofType type: AnswerType) -> Answer {
        guard let answer = answers.first(where: { $0.type == type }) else {
            fatalError("Response does not contain \(type.rawValue) answer data")
        }

        return answer
    }

}

extension DebateDeserializer {

    static func build() -> Deserializer<Debate> {
        return Deserializer(
            DebateDeserializer(
                answerDeserializer: Deserializer(AnswerDeserializer())
            )
        )
    }

}
