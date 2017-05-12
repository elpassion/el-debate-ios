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
        guard let dict = json as? [String: Any] else {
            throw RequestError.deserializationError(reason: "Response is not a dictionary")
        }

        guard let identifier = dict["id"] as? Int else {
            throw RequestError.deserializationError(reason: "Response does not contain answer identifier")
        }

        guard let value = dict["value"] as? String else {
            throw RequestError.deserializationError(reason: "Response does not contain answers value")
        }

        return Answer(identifier: identifier, value: value)
    }
}
