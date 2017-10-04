@testable import ELDebateFramework
import EarlGrey
import EarlGreySnapshots
import XCTest

class PinEntryScreenTests: XCTestCase {

    override func setUp() {
        super.setUp()

        GREYTestHelper.enableFastAnimation()
        KeychainFixtures.enable()
        RouterFixtures.enable()
        UserDefaultsFixtures.enable()
    }

    func testPinEntryScreenShouldDisplayPinInput() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .atIndex(1)
            .assert(grey_hasPlaceholder("EL Debate PIN"))
    }

    func testPinEntryScreenShouldDisplayLoginButton() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UIButton.self))
            .assert(grey_buttonTitle("Log in"))
    }

    func testLoginWorks() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .atIndex(1)
            .perform(grey_typeText(KeychainFixtures.testPinCode))

        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Log in"))
            .perform(grey_tap())

        EarlGrey.select(elementWithMatcher: grey_text("Our debate is about:"))
            .assert(grey_sufficientlyVisible())
    }

    func testWelcomeViewMatches() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(PinEntryWelcomeView.self))
            .assert(grey_verifyDeviceAgnosticSnapshot())
    }

    func testLoginButtonSlidesUpWhenEnteringPin() {
        EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextField.self))
            .atIndex(1)
            .perform(grey_typeText("12345"))

        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Log in"))
            .assert(grey_sufficientlyVisible())
    }

}
