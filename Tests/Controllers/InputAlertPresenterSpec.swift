//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

internal class InputAlertPresenterSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("InputAlertPresenter") {
            var alertFactory: AlertFactoryMock!
            var controller: PresentControllerSpy!
            var sut: InputAlertPresenter!

            beforeEach {
                alertFactory = AlertFactoryMock()
                controller = PresentControllerSpy()
                sut = InputAlertPresenter()
            }

            when("prompting") {
                var result: Promise<String?>!

                beforeEach {
                    let configuration = InputAlertConfiguration(title: "Prompt",
                                                                message: "Body",
                                                                cancelTitle: "Nope",
                                                                okTitle: "Okay",
                                                                inputPlaceholder: "Hold the place")

                    result = sut.prompt(in: controller, with: configuration, alertFactory: alertFactory)
                }

                it("should present an alert in a controller") {
                    expect(controller.hasPresentedController) == alertFactory.returnedAlert
                }

                it("should create an alert with proper message and title") {
                    expect(alertFactory.lastConfiguration?.title) == "Prompt"
                    expect(alertFactory.lastConfiguration?.message) == "Body"
                }

                it("should create an alert with two actions") {
                    expect(alertFactory.lastConfiguration?.actions.count) == 2
                    expect(alertFactory.lastConfiguration?.actions.first?.title) == "Nope"
                    expect(alertFactory.lastConfiguration?.actions.first?.style) == UIAlertActionStyle.cancel
                    expect(alertFactory.lastConfiguration?.actions.last?.title) == "Okay"
                    expect(alertFactory.lastConfiguration?.actions.last?.style) == UIAlertActionStyle.default
                }

                it("should create an alert with a single placeholder") {
                    expect(alertFactory.lastConfiguration?.textFields.count) == 1
                    expect(alertFactory.lastConfiguration?.textFields.first?.placeholder) == "Hold the place"
                }

                when("cancel action is triggered") {
                    it("should return nil string input") {
                        var receivedInput: String? = "input"
                        _ = result.then { receivedInput = $0 }

                        alertFactory.lastConfiguration?.actions.first?.handler?()

                        expect(receivedInput).toEventually(beNil())
                    }
                }

                when("send action is triggered") {
                    it("should return string from textfield input") {
                        var receivedInput: String?
                        _ = result.then { receivedInput = $0 }
                        alertFactory.returnedAlert.addTextField { textField in
                            textField.text = "The input"
                        }

                        alertFactory.lastConfiguration?.actions.last?.handler?()

                        expect(receivedInput).toEventually(equal("The input"))
                    }
                }
            }
        }
    }

}
