@testable import ELDebateFramework
import Nimble
import Quick

class DictionaryMergingSpec: QuickSpec {

    override func spec() {
        describe("Dictionary") {
            describe("merge") {
                it("should return merged dictionary") {
                    let first: [String: Int] = ["A": 1, "B": 2]
                    let second: [String: Int] = ["B": 3, "C": 4]

                    let merged = first.merge(second)

                    expect(merged) == ["A": 1, "B": 3, "C": 4]
                }
            }
        }
    }

}
