import ELDebateFramework
import Nimble
import Quick

internal class Int_AsTimeStringSpec: QuickSpec {

    override func spec() {
        var testedInteger: NSInteger!

        beforeEach {
            testedInteger = 1510681264000
        }

        afterEach {
            testedInteger = nil
        }

        describe("AsTimeString") {
            it("should convert timestamp from API to proper value") {
                let output = testedInteger.asTimeStringWithZone(zone: TimeZone(identifier: "GMT")!)
                expect(output) == "17:41"
            }
        }
    }
}
