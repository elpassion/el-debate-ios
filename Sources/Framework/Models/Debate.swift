import Foundation

struct Debate {

    let topic: String
    let positiveAnswer: Answer
    let neutralAnswer: Answer
    let negativeAnswer: Answer
    let lastAnswerIdentifier: Int?

}

extension Debate {

    public var lastAnswerType: AnswerType? {
        let answers: [Answer] = [positiveAnswer, neutralAnswer, negativeAnswer]
        return answers.first { $0.identifier == lastAnswerIdentifier }?.type
    }

}
