@testable import ELDebateFramework

extension Debate {

    static var testDefault: Debate {
        return Debate(topic: "test_debate_topic",
                      positiveAnswer: Answer(identifier: 1, value: "positive", type: .positive),
                      neutralAnswer: Answer(identifier: 2, value: "neutral", type: .neutral),
                      negativeAnswer: Answer(identifier: 3, value: "negative", type: .negative),
                      lastAnswerIdentifier: 3)
    }

}
