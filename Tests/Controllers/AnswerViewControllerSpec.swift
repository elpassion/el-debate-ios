//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class AnswerViewControllerSpec: QuickSpec {

    override func spec() {
        describe("AnswerViewController") {
            var yearCalculator: CurrentYearCalculatorMock!
            var controller: AnswerViewController!

            beforeEach {
                yearCalculator = CurrentYearCalculatorMock()
                yearCalculator.year = "2012"
                controller = AnswerViewController(yearCalculator: yearCalculator)
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title).to(equal("EL Debate 2012"))
                }
            }
        }
    }
}
