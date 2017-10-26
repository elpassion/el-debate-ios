@testable import ELDebateFramework
import Quick
import Nimble

class UITableViewCell_ReusableSpec: QuickSpec {

    override func spec() {
        describe("Reusable") {
            describe("UITableViewCell") {
                it("should have correct reuseIdentifier") {
                    expect(UITableViewCell.reuseIdentifier) == "UITableViewCell"
                }
            }
        }
    }

}
