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

        let answers = try answersWithTypes(answersData)
            .map { try answerDeserializer.deserialize(json: $0) }

        return Debate(topic: topic,
                      positiveAnswer: try answer(from: answers, ofType: .positive),
                      neutralAnswer: try answer(from: answers, ofType: .neutral),
                      negativeAnswer: try answer(from: answers, ofType: .negative))
    }

    private func answersWithTypes(_ answersJSON: [String: [String: Any?]]) -> [[String: Any?]] {
        let mappedAnswersJSON = answersJSON.mapDictionary { (typeKey, singleAnswerJSON) in
            (typeKey, singleAnswerJSON.merge(["answer_type": typeKey]))
        }

        return Array(mappedAnswersJSON.values)
    }

    private func answer(from answers: [Answer], ofType type: AnswerType) throws -> Answer {
        guard let answer = answers.first(where: { $0.type == type }) else {
            throw RequestError.deserializationError(reason: "Response does not contain \(type.rawValue) answer data")
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
