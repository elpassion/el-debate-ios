//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class PinEntryViewControllerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("PinEntryViewController") {
            var loginActionHandlingMock: LoginActionHandlingMock!
            var alertViewMock: AlertViewMock!
            var keyboardHandler: KeyboardWillShowHandlerMock!
            var controller: PinEntryViewController!

            beforeEach {
                loginActionHandlingMock = LoginActionHandlingMock()
                alertViewMock = AlertViewMock()
                keyboardHandler = KeyboardWillShowHandlerMock()
                controller = PinEntryViewController(loginActionHandler: loginActionHandlingMock,
                                                    alertView: alertViewMock,
                                                    keyboardHandling: keyboardHandler)
            }

            it("should initialize back bar button item") {
                expect(controller.navigationItem.backBarButtonItem?.title) == ""
                expect(controller.navigationItem.backBarButtonItem?.style) == UIBarButtonItemStyle.plain
                expect(controller.navigationItem.backBarButtonItem?.action).to(beNil())
                expect(controller.navigationItem.backBarButtonItem?.target).to(beNil())
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title) == "EL Debate"
                }

                it("should have a valid snapshot") {
                    controller.view.frame = UIScreen.main.bounds

                    expect(controller.view).to(haveValidDeviceAgnosticSnapshot())
                }
            }

            describe("log in button press") {
                context("action was successful") {
                    beforeEach {
                        loginActionHandlingMock.loginReturnValue = Promise(value: VoteContext.testDefault)
                        loginActionHandlingMock.loginReceivedPinCode = nil
                    }

                    it("should trigger successful login callback with correct authentication token") {
                        var fetchedVoteContext: VoteContext?

                        controller.onVoteContextLoaded = { voteContext in
                            fetchedVoteContext = voteContext
                        }

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(fetchedVoteContext?.debate.topic).toEventually(equal("test_debate_topic"))
                    }

                    it("should pass pin from view") {
                        controller.pinEntryView.pinCode = "99999"

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(loginActionHandlingMock.loginReceivedPinCode).toEventually(equal("99999"))
                    }
                }

                context("there was a problem") {
                    beforeEach {
                        loginActionHandlingMock.loginReturnValue = Promise(
                            error: RequestError.apiError(statusCode: 500)
                        )
                    }

                    it("shows an error alert") {
                        controller.onLoginButtonTapped()
                        expect(alertViewMock.wasShown).toEventually(equal(true))
                    }
                }
            }

            describe("keyboard event") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should play the animation with keyboard height") {
                    keyboardHandler.onKeyboardHeightChanged?(CGFloat(250.0))

                    expect(controller.pinEntryView.buttonBottomConstraint?.constant) == -265.0
                }
            }
        }
    }

}
