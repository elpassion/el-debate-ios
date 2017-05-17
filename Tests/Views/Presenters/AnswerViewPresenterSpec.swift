//
//  AnswerViewPresenterSpec.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 16/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class AnswerViewPresenterSpec: QuickSpec {
    override func spec() {
        var answerView: AnswerViewMock!
        var debate: Debate!
        var sut: AnswerViewPresenter!

        describe("AnswerViewPresenter") {
            beforeEach {
                answerView = AnswerViewMock()
                debate = Debate(
                    topic: "whatever",
                    positiveAnswer: Answer(identifier: 123, value: "yes"),
                    neutralAnswer: Answer(identifier: 124, value: "maybe"),
                    negativeAnswer: Answer(identifier: 125, value: "no")
                )

                sut = AnswerViewPresenter()
            }

            describe("config") {
                it("sets executes config method with correct values from debate on answerView") {
                    sut.present(debate: debate, answerView: answerView)
                    expect(answerView.debateTitle).to(equal("whatever"))
                    expect(answerView.yesAnswerText).to(equal("yes"))
                    expect(answerView.undecidedAnswerText).to(equal("maybe"))
                    expect(answerView.noAnswerText).to(equal("no"))
                }
            }
        }
    }
}
