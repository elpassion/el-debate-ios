//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//
// swiftlint:disable function_body_length

@testable import ELDebate
import Nimble
import PromiseKit
import Quick

class PinEntryViewControllerSpec: QuickSpec {

    override func spec() {
        describe("PinEntryViewController") {
            var loginActionHandlingMock: LoginActionHandlingMock!
            var yearCalculator: CurrentYearCalculatorMock!
            var alertViewMock: AlertViewMock!
            var controller: PinEntryViewController!

            beforeEach {
                loginActionHandlingMock = LoginActionHandlingMock()
                yearCalculator = CurrentYearCalculatorMock()
                yearCalculator.year = "2023"
                alertViewMock = AlertViewMock()
                controller = PinEntryViewController(loginActionHandler: loginActionHandlingMock,
                                                    yearCalculator: yearCalculator, alertView: alertViewMock)
            }

            it("should initialize back bar button item") {
                expect(controller.navigationItem.backBarButtonItem?.title).to(equal(""))
                expect(controller.navigationItem.backBarButtonItem?.style).to(equal(UIBarButtonItemStyle.plain))
                expect(controller.navigationItem.backBarButtonItem?.action).to(beNil())
                expect(controller.navigationItem.backBarButtonItem?.target).to(beNil())
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title).to(equal("EL Debate 2023"))
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
        }
    }
}
