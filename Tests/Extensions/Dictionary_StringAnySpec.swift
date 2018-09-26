@testable import ELDebateFramework
import Nimble
import Quick

class Dictionary_StringAnySpec: QuickSpec {

    override func spec() {
        describe("Dictionary+StringAny") {
            it("should convert [NSAttributedStringKey: AnyObject] dict type to [String: Any]") {
                let dictionary: [NSAttributedString.Key: AnyObject] = [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
                ]

                let expectedDictionary: [String: Any] = [
                    NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 18)
                ]

                expect(dictionary.stringAny.description) == expectedDictionary.description
            }
        }
    }

}
