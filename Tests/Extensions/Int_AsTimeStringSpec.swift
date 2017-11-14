import ELDebateFramework
import Nimble
import Quick

internal class Int_AsTimeStringSpec: QuickSpec {

    override func spec() {
        describe("AsTimeString") {
            it("should convert timestamp from API to proper value") {
                let testInt = 1510681264000
                let output = testInt.asTimeString()
            }
        }
    }
}
