@testable import ELDebateFramework
import Nimble
import Quick
import UIColor_Hex_Swift
import UIKit

class FontSizeCalculatorSpec: QuickSpec {

    override func spec() {
        describe("FontSizeCalculator") {
            var sut: FontSizeCalculator!

            beforeEach {
                sut = FontSizeCalculator()
            }

            describe("calculating size") {
                it("should return input for reference height") {
                    let result = sut.size(withReferenceSize: 20.0, forScreenHeight: 667.0)

                    expect(result) == 20.0
                }

                it("should return upscaled font for big reference height") {
                    let result = sut.size(withReferenceSize: 20.0, forScreenHeight: 736.0)

                    expect(result) == 22.0
                }

                it("should return downscaled font for small reference height") {
                    let result = sut.size(withReferenceSize: 20.0, forScreenHeight: 568.0)

                    expect(result) == 17.0
                }
            }
        }
    }

}
