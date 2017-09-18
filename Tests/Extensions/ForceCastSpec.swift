import ELDebateFramework
import Nimble
import Quick

internal class ForceCastSpec: QuickSpec {

    override func spec() {
        describe("ForceCast") {
            it("should throw an assertion if casting fails") {
                expect { () -> Void in
                    let _: Int = forceCast("Hello")
                }.to(throwAssertion())
            }

            it("should do the cast if possible") {
                let answerPicker: UIView = AnswerPicker()

                let result: AnswerPicker = forceCast(answerPicker)

                expect(result) == answerPicker
            }
        }
    }

}
