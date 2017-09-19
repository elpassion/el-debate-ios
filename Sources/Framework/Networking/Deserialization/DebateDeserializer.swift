import Foundation

class DebateDeserializer: Deserializing {

    private let answerDeserializer: Deserializer<Answer>

    init(answerDeserializer: Deserializer<Answer>) {
        self.answerDeserializer = answerDeserializer
    }

    func deserialize(json: Any?) throws -> Debate {
        let dict = try parseDictionary(json)
        let topic: String = try parseField(from: dict, key: "topic", description: "debate topic")
        let answersData: [String: [String: Any]] = try parseField(
            from: dict, key: "answers", description: "answers data")
        let lastAnswerIdentifier = dict["last_answer_id"] as? Int

        let answers = try answersWithTypes(answersData)
            .map { try answerDeserializer.deserialize(json: $0) }

        return Debate(topic: topic,
                      positiveAnswer: try answer(from: answers, ofType: .positive),
                      neutralAnswer: try answer(from: answers, ofType: .neutral),
                      negativeAnswer: try answer(from: answers, ofType: .negative),
                      lastAnswerIdentifier: lastAnswerIdentifier)
    }

    private func answersWithTypes(_ answersJSON: [String: [String: Any?]]) -> [[String: Any?]] {
        let mappedAnswersJSON = answersJSON.mapDictionary { typeKey, singleAnswerJSON in
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
