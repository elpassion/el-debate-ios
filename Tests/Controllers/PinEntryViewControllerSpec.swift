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
                    store.lastCredentials = LoginCredentials(pin: "777", username: "Lucker")
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
                    expect(controller.pinEntryView.credentials.pin) == "777"
                    expect(controller.pinEntryView.credentials.username) == "Lucker"
                }

                context("when there are no credentials") {
                    beforeEach {
                        store.lastCredentials = nil
                        controller.viewDidLoad()
                    }

                    it("should set empty pin and username") {
                        expect(controller.pinEntryView.credentials.pin) == ""
                        expect(controller.pinEntryView.credentials.username) == ""
                    }
                }
            }

            describe("log in button press") {
                beforeEach {
                    loginActionHandlingMock.loginReturnValue = Promise(value: VoteContext.testDefault)
                    loginActionHandlingMock.loginReceivedCredentials = nil
                }

                context("validation failed") {
                    beforeEach {
                        loginActionHandlingMock.loginReturnValue = Promise(error: PinCodeValidatorError.missing)
                    }

                    it("should present an error") {
                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(alertViewMock.wasShown).toEventually(beTrue())
                        expect(alertViewMock.title).toEventually(equal("Error"))
                        expect(alertViewMock.message).toEventually(equal("The PIN code is required"))
                    }
                }

                it("should pass form data from view") {
                    controller.pinEntryView.credentials = LoginCredentials(pin: "99999", username: "I am the user")

                    controller.pinEntryView.onLoginButtonTapped?()

                    expect(loginActionHandlingMock.loginReceivedCredentials?.pin).toEventually(equal("99999"))
                    expect(loginActionHandlingMock.loginReceivedCredentials?.username).toEventually(
                        equal("I am the user"))
                }

                context("action was successful") {
                    it("should trigger successful login callback with vote context from action") {
                        var fetchedVoteContext: VoteContext?
                        controller.onVoteContextLoaded = { voteContext in
                            fetchedVoteContext = voteContext
                        }

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(fetchedVoteContext?.debate.topic).toEventually(equal("test_debate_topic"))
                        expect(fetchedVoteContext?.authToken).toEventually(equal("whatever"))
                        expect(fetchedVoteContext?.username).toEventually(equal("some user"))
                    }

                    it("should store credentials in store") {
                        controller.pinEntryView.credentials = LoginCredentials(pin: "9812367", username: "Teh Dev")

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(store.lastCredentials?.pin).toEventually(equal("9812367"))
                        expect(store.lastCredentials?.username).toEventually(equal("Teh Dev"))
                    }
                }

                context("api client returns invalid response") {
                    beforeEach {
                        store.lastCredentials = LoginCredentials(pin: "777", username: "Lucker")
                        loginActionHandlingMock.loginReturnValue = Promise(
                            error: RequestError.apiError(statusCode: 500)
                        )
                    }

                    it("shows an error alert") {
                        controller.onLoginButtonTapped()

                        expect(alertViewMock.wasShown).toEventually(equal(true))
                        expect(alertViewMock.title).toEventually(equal("Error"))
                        expect(alertViewMock.message).toEventually(
                                equal("Could not find a debate for a given pin code"))
                    }

                    it("should not store credentials in store") {
                        controller.pinEntryView.credentials = LoginCredentials(pin: "9812367", username: "Teh Dev")

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(store.lastCredentials?.pin) == "777"
                        expect(store.lastCredentials?.username) == "Lucker"
                    }
                }
            }

            describe("keyboard event") {
                beforeEach {
                    controller.view.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 504.0)
                    controller.view.layoutSubviews()
                }

                it("should default constraints for zero height") {
                    keyboardHandler.onKeyboardHeightChanged?(CGFloat(0.0))

                    expect(controller.pinEntryView.loginButtonBottomConstraint?.constant) == -15.0
                    expect(controller.pinEntryView.pinInputBottomConstraint?.constant) == -10.0
                }

                it("should play the animation for non-zero height") {
                    keyboardHandler.onKeyboardHeightChanged?(CGFloat(216.0))

                    expect(controller.pinEntryView.loginButtonBottomConstraint?.constant) < -15.0
                    expect(controller.pinEntryView.pinInputBottomConstraint?.constant) < -10.0
                }
            }
        }
    }

}
