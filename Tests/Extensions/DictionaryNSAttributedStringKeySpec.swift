@testable import ELDebateFramework
import Nimble
import Quick

class DictionaryNSAttributedStringKeySpec: QuickSpec {

    override func spec() {
        describe("Dictionary") {
            it("should convert type of value from NSAttributedStringKey to String") {
                let dictionary: [NSAttributedStringKey: AnyObject] = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]

                let expectedDictionary: [String: Any] = [
                    NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 18)
                ]

                expect(dictionary.stringAny.description) == expectedDictionary.description
            }
        }
    }

}
