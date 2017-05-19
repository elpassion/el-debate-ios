//
//  Created by Jakub Turek on 17.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import EarlGrey
import EarlGreySnapshots
import XCTest

class AnswerScreenTests: XCTestCase {

    override func setUp() {
        super.setUp()

        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Expected to manage AppDelegate")
        }

        GREYTestHelper.enableFastAnimation()
        applicationDelegate.reset()
        navigateToAnswerScreen()
    }

    func testDebateDetailsAreFetchedProperly() {
        EarlGrey.select(elementWithMatcher: grey_text("Party craft beer leggings Pitchfork VHS locavore?"))
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_text("Yes"))
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_text("No"))
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_text("Undecided"))
            .assert(grey_sufficientlyVisible())
    }

    func testPositiveVoteWorks() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(SingleAnswerView.self))
            .atIndex(0)
            .perform(grey_tap())
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_kindOfClass(AnswerPicker.self))
            .perform(grey_verifyDeviceAgnosticSnapshot())
    }

    func testNegativeVoteWorks() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(SingleAnswerView.self))
            .atIndex(1)
            .perform(grey_tap())
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_kindOfClass(AnswerPicker.self))
            .perform(grey_verifyDeviceAgnosticSnapshot())
    }

    func testNeutralVoteWorks() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(SingleAnswerView.self))
            .atIndex(2)
            .perform(grey_tap())
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_kindOfClass(AnswerPicker.self))
            .perform(grey_verifyDeviceAgnosticSnapshot())
    }

    private func navigateToAnswerScreen() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .perform(grey_typeText("13160"))

        EarlGrey.select(elementWithMatcher: grey_text("Welcome to"))
            .perform(grey_tap())

        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Log in"))
            .perform(grey_tap())
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_text("Our debate is about:"))
            .assert(grey_sufficientlyVisible())
    }
    
}
