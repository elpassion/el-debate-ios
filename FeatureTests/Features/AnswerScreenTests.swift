//
//  Created by Jakub Turek on 17.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import EarlGrey
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
