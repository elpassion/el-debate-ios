//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate

extension Debate {

    static var testDefault: Debate {
        return Debate(topic: "test_debate_topic",
                      positiveAnswer: Answer(identifier: 1, value: "positive", type: .positive),
                      neutralAnswer: Answer(identifier: 2, value: "neutral", type: .neutral),
                      negativeAnswer: Answer(identifier: 3, value: "negative", type: .negative))
    }

}
