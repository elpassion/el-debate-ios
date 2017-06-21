//
//  Created by Jakub Turek on 21.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick

class DebateSpec: QuickSpec {

    override func spec() {
        describe("Debate") {
            var sut: Debate!

            context("when last answer is set") {
                beforeEach {
                    sut = Debate(topic: "Topic",
                                 positiveAnswer: Answer(identifier: 7, value: "OH YES", type: .positive),
                                 neutralAnswer: Answer(identifier: 18, value: "OH NEUTRAL", type: .neutral),
                                 negativeAnswer: Answer(identifier: 99, value: "OH NO", type: .negative),
                                 lastAnswerIdentifier: 18)
                }

                it("should return proper answer type") {
                    expect(sut.lastAnswerType) == AnswerType.neutral
                }
            }

            context("when last answer is not set") {
                beforeEach {
                    sut = Debate(topic: "Topic",
                                 positiveAnswer: Answer(identifier: 7, value: "OH YES", type: .positive),
                                 neutralAnswer: Answer(identifier: 18, value: "OH NEUTRAL", type: .neutral),
                                 negativeAnswer: Answer(identifier: 99, value: "OH NO", type: .negative),
                                 lastAnswerIdentifier: nil)
                }

                it("should return nil as answer type") {
                    expect(sut.lastAnswerType).to(beNil())
                }
            }
        }
    }

}
