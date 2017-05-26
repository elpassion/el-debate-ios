//
//  Created by Jakub Turek on 16.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import EarlGrey
import EarlGreySnapshots
import XCTest

class PinEntryScreenTests: XCTestCase {

    override func setUp() {
        super.setUp()

        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Expected to manage AppDelegate")
        }

        GREYTestHelper.enableFastAnimation()
        applicationDelegate.reset()
    }

    func testPinEntryScreenShouldDisplayPinInput() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .assert(grey_hasPlaceholder("Enter EL Debate PIN"))
    }

    func testPinEntryScreenShouldDisplayLoginButton() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UIButton.self))
            .assert(grey_buttonTitle("Log in"))
    }

    func testLoginWorks() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .perform(grey_typeText("13160"))

        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Log in"))
            .perform(grey_tap())
            .assert(grey_sufficientlyVisible())

        EarlGrey.select(elementWithMatcher: grey_text("Our debate is about:"))
            .assert(grey_sufficientlyVisible())
    }

    func testWelcomeViewMatches() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(PinEntryWelcomeView.self))
            .assert(grey_verifyDeviceAgnosticSnapshot())
    }

    func testLoginButtonSlidesUpWhenEnteringPin() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .perform(grey_typeText("12345"))

        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Log in"))
            .assert(grey_sufficientlyVisible())
    }

}
