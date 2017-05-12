//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class PinEntryControllerSpec: QuickSpec {

    override func spec() {
        describe("PinEntryViewController") {
            var yearCalculator: CurrentYearCalculatorMock!
            var controller: PinEntryViewController!

            beforeEach {
                yearCalculator = CurrentYearCalculatorMock()
                yearCalculator.year = "2023"
                controller = PinEntryViewController(apiClient: APIProvidingMock(),
                                                    yearCalculator: yearCalculator)
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title).to(equal("EL Debate 2023"))
                }
            }
        }
    }
}
