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
            var formValidator: PinFormValidatorMock!
            var controller: PinEntryViewController!

            beforeEach {
                loginActionHandlingMock = LoginActionHandlingMock()
                alertViewMock = AlertViewMock()
                keyboardHandler = KeyboardWillShowHandlerMock()
                store = LoginCredentialsStoreMock()
                formValidator = PinFormValidatorMock()
                controller = PinEntryViewController(loginActionHandler: loginActionHandlingMock,
                                                    alertView: alertViewMock,
                                                    keyboardHandling: keyboardHandler,
                                                    lastCredentialsStore: store,
                                                    formValidator: formValidator)
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
                context("validation failed") {
                    beforeEach {
                        formValidator.error = PinCodeValidatorError.missing
                    }

                    it("should present an error") {
                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(alertViewMock.wasShown).toEventually(beTrue())
                        expect(alertViewMock.title).toEventually(equal("Error"))
                        expect(alertViewMock.message).toEventually(equal("The PIN code is required"))
                    }
                }

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
                        controller.pinEntryView.credentials = LoginCredentials(pin: "", username: "The username")
                        controller.onVoteContextLoaded = { voteContext in
                            username = voteContext.username
                        }

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(username).toEventually(equal("The username"))
                    }

                    it("should pass pin from view") {
                        controller.pinEntryView.credentials = LoginCredentials(pin: "99999", username: "")

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(loginActionHandlingMock.loginReceivedPinCode).toEventually(equal("99999"))
                    }

                    it("should store credentials in store") {
                        controller.pinEntryView.credentials = LoginCredentials(pin: "9812367", username: "Teh Dev")

                        controller.pinEntryView.onLoginButtonTapped?()

                        expect(store.lastCredentials?.pin).toEventually(equal("9812367"))
                        expect(store.lastCredentials?.username).toEventually(equal("Teh Dev"))
                    }
                }

                context("there was a problem") {
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
