//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import PromiseKit
import Quick

class PinEntryViewControllerSpec: QuickSpec {

    override func spec() {
        describe("PinEntryViewController") {
            var loginActionHandlingMock: LoginActionHandlingMock!
            var yearCalculator: CurrentYearCalculatorMock!
            var controller: PinEntryViewController!

            beforeEach {
                loginActionHandlingMock = LoginActionHandlingMock()
                yearCalculator = CurrentYearCalculatorMock()
                yearCalculator.year = "2023"
                controller = PinEntryViewController(loginActionHandler: loginActionHandlingMock,
                                                    yearCalculator: yearCalculator)
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
                beforeEach {
                    loginActionHandlingMock.loginReturnValue = Promise(value: Debate.testDefault)
                    loginActionHandlingMock.loginReceivedPinCode = nil
                }

                it("should trigger successful login callback with correct authentication token") {
                    var fetchedDebate: Debate?

                    controller.onDebateLoaded = { debate in
                        fetchedDebate = debate
                    }

                    controller.pinEntryView.onLoginButtonTapped?()

                    expect(fetchedDebate?.topic).toEventually(equal("test_debate_topic"))
                }

                it("should pass pin from view") {
                    controller.pinEntryView.pinCode = "99999"

                    controller.pinEntryView.onLoginButtonTapped?()

                    expect(loginActionHandlingMock.loginReceivedPinCode).toEventually(equal("99999"))
                }
            }
        }
    }
}
