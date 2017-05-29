//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class CurrentYearCalculatorSpec: QuickSpec {

    override func spec() {
        describe("CurrentYearCalculator") {
            var yearCalculator: CurrentYearCalculator!

            beforeEach {
                yearCalculator = CurrentYearCalculator(currentDateProvider: { Date(timeIntervalSince1970: 631843200) })
            }

            describe("year") {
                it("should provide correct value") {
                    let year = yearCalculator.year

                    expect(year).to(equal("1990"))
                }
            }
        }
    }

}
