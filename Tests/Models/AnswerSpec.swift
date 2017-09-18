@testable import ELDebateFramework
import Nimble
import Quick

internal class AnswerSpec: QuickSpec {

    override func spec() {
        describe("AnswerType") {
            it("should correctly report all types") {
                let allTypes = AnswerType.allTypes

                expect(allTypes.count) == 3
                expect(allTypes).to(contain(AnswerType.positive))
                expect(allTypes).to(contain(AnswerType.neutral))
                expect(allTypes).to(contain(AnswerType.negative))
            }
        }
    }

}
