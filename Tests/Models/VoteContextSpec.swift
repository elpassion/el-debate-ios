@testable import ELDebateFramework
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
                    sut = VoteContext(debate: debate, authToken: "auth_token_value", username: "Some username")
                }

                it("returns the correct id for a given AnswerType") {
                    expect(sut.answer(for: .positive).identifier) == 1
                }
            }
        }
    }

}
