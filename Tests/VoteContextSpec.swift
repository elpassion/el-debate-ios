//
//  VoteContextSpec.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 16/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class VoteContextSpec: QuickSpec {
    override func spec() {
        describe("VoteContext") {
            describe("answer") {
                var sut: VoteContext!
                var debate: Debate!

                beforeEach {
                    debate = Debate.testDefault
                    sut = VoteContext(debate: debate, authToken: "auth_token_value")
                }

                it("returns the correct id for a given AnswerType") {
                    expect(sut.answer(for: .positive).identifier).to(equal(1))
                }
            }
        }
    }
}
