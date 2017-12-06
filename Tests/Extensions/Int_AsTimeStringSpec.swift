import ELDebateFramework
import Nimble
import Quick

internal class Int_AsTimeStringSpec: QuickSpec {

    override func spec() {
        var testedInteger: NSInteger!

        beforeEach {
            testedInteger = 1510681264000
            NSTimeZone.default = NSTimeZone(abbreviation: "CET")! as TimeZone
        }

        afterEach {
            testedInteger = nil
            NSTimeZone.resetSystemTimeZone()
        }

        describe("AsTimeString") {
            it("should convert timestamp from API to proper value") {
                let output = testedInteger.asTimeString()
                expect(output) == "18:41"
            }
        }
    }
}
