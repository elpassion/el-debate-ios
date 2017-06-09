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
            var store: LoginCredentialsStoreMock!
            var controller: PinEntryViewController!

            beforeEach {
                loginActionHandlingMock = LoginActionHandlingMock()
                alertViewMock = AlertViewMock()
                keyboardHandler = KeyboardWillShowHandlerMock()
                store = LoginCredentialsStoreMock()
                controller = PinEntryViewController(loginActionHandler: loginActionHandlingMock,
                                                    alertView: alertViewMock,
                                                    keyboardHandling: keyboardHandler,
                                                    lastCredentialsStore: store)
            }

            it("should initialize back bar button item") {
                expect(controller.navigationItem.backBarButtonItem?.title) == ""
                expect(controller.navigationItem.backBarButtonItem?.style) == UIBarButtonItemStyle.plain
                expect(controller.navigationItem.backBarButtonItem?.action).to(beNil())
                expect(controller.navigationItem.backBarButtonItem?.target).to(beNil())
            }

            describe("after view is loaded") {
                beforeEach {
                    store.lastCredentials = LoginCredentials(pinCode: "777", username: "Lucker")
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title) == "EL Debate"
                }

                it("should have a valid snapshot") {
                    controller.view.frame = UIScreen.main.bounds

                    expect(controller.view).to(haveValidDeviceAgnosticSnapshot())
                }

                it("should set field values from login store") {
                    expect(controller.pinEntryView.pinCode) == "777"
                    expect(controller.pinEntryView.username) == "Lucker"
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

                    it("should pass username from text field value") {
                        var username: String?
                        controller.pinEntryView.username = "The username"
                        controller.onVoteContextLoaded = { voteContext in
                            username = voteContext.username
                        }

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(username).toEventually(equal("The username"))
                    }

                    it("should pass pin from view") {
                        controller.pinEntryView.pinCode = "99999"

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(loginActionHandlingMock.loginReceivedPinCode).toEventually(equal("99999"))
                    }

                    it("should store credentials in store") {
                        controller.pinEntryView.pinCode = "9812367"
                        controller.pinEntryView.username = "Teh Dev"

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(store.lastCredentials?.pinCode).toEventually(equal("9812367"))
                        expect(store.lastCredentials?.username).toEventually(equal("Teh Dev"))
                    }
                }

                context("there was a problem") {
                    beforeEach {
                        store.lastCredentials = LoginCredentials(pinCode: "777", username: "Lucker")
                        loginActionHandlingMock.loginReturnValue = Promise(
                            error: RequestError.apiError(statusCode: 500)
                        )
                    }

                    it("shows an error alert") {
                        controller.onLoginButtonTapped()
                        expect(alertViewMock.wasShown).toEventually(equal(true))
                    }

                    it("should not store credentials in store") {
                        controller.pinEntryView.pinCode = "9812367"
                        controller.pinEntryView.username = "Teh Dev"

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(store.lastCredentials?.pinCode) == "777"
                        expect(store.lastCredentials?.username) == "Lucker"
                    }
                }
            }

            describe("keyboard event") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should play the correct animation for zero height") {
                    keyboardHandler.onKeyboardHeightChanged?(CGFloat(0.0))

                    expect(controller.pinEntryView.loginButtonBottonConstraint?.constant) == -15.0
                    expect(controller.pinEntryView.pinInputCenterConstraint?.isActive) == true
                    expect(controller.pinEntryView.pinInputBottomConstraint?.isActive) == false
                }

                it("should play the correct animation for non-zero height") {
                    keyboardHandler.onKeyboardHeightChanged?(CGFloat(200.0))

                    expect(controller.pinEntryView.loginButtonBottonConstraint?.constant) == -215.0
                    expect(controller.pinEntryView.pinInputCenterConstraint?.isActive) == false
                    expect(controller.pinEntryView.pinInputBottomConstraint?.isActive) == true
                }
            }
        }
    }

}
