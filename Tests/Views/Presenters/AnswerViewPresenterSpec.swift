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
                debate = Debate.testDefault

                sut = AnswerViewPresenter()
            }

            describe("config") {
                it("sets executes config method with correct values from debate on answerView") {
                    sut.present(debate: debate, answerView: answerView)
                    expect(answerView.debateTitle).to(equal("test_debate_topic"))
                    expect(answerView.yesAnswerText).to(equal("positive"))
                    expect(answerView.undecidedAnswerText).to(equal("neutral"))
                    expect(answerView.noAnswerText).to(equal("negative"))
                }
            }
        }
    }
}
