//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Nimble_Snapshots
import Quick

class AnswerViewControllerSpec: QuickSpec {

    override func spec() {
        describe("AnswerViewController") {
            var yearCalculator: CurrentYearCalculatorMock!
            var controller: AnswerViewController!

            beforeEach {
                yearCalculator = CurrentYearCalculatorMock()
                yearCalculator.year = "2012"
                controller = AnswerViewController(
                    yearCalculator: yearCalculator,
                    voteContext: VoteContext.testDefault,
                    answerViewPresenter: AnswerViewPresenter(),
                    apiClient: APIProviderStub()
                )
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title).to(equal("EL Debate 2012"))
                }

                it("should have a valid snaphot") {
                    controller.view.frame = UIScreen.main.bounds

                    expect(controller.view).to(haveValidSnapshot())
                }
            }
        }
    }
}
