//
//  AnswerDeserializer.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class AnswerDeserializer: Deserializing {

    func deserialize(json: Any?) throws -> Answer {
        let dict = try parseDictionary(json)
        let identifier: Int = try parseField(from: dict, key: "id", description: "answer identifier")
        let value: String = try parseField(from: dict, key: "value", description: "answer value")
        let answerType = try parseAnswerType(dict)

        return Answer(identifier: identifier, value: value, type: answerType)
    }

    private func parseAnswerType(_ dictionary: [String: Any]) throws -> AnswerType {
        guard let answerType = dictionary["answer_type"].flatMap(AnswerType.init(rawType:)) else {
            throw RequestError.deserializationError(reason: "Response does not contain correct answer type")
        }

        return answerType
    }

}
