//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

internal class AlertPresenterSpec: QuickSpec {

    override func spec() {
        describe("presentAlert") {
            var alertPresenting: AlertPresentingControllerMock!

            beforeEach {
                alertPresenting = AlertPresentingControllerMock()
                alertPresenting.presenterMock.showReturnValue = Promise(value: true)
            }

            when("alert presenter is nil") {
                it("should return an error") {
                    var hasDeallocatedClient = false

                    _ = presentAlert(in: nil, title: "Title", message: "Message")
                        .catch { error in
                            if case RequestError.deallocatedClientError = error {
                                hasDeallocatedClient = true
                            }
                        }

                    expect(hasDeallocatedClient).toEventually(beTrue())
                }
            }

            it("should present an error") {
                presentAlert(in: alertPresenting, title: "Title", message: "Message")

                expect(alertPresenting.presenterMock.showReceivedArguments?.controller) == alertPresenting.controller
                expect(alertPresenting.presenterMock.showReceivedArguments?.title) == "Title"
                expect(alertPresenting.presenterMock.showReceivedArguments?.message) == "Message"
            }

            when("title is nil") {
                it("should present an alert with empty title") {
                    presentAlert(in: alertPresenting, title: nil, message: "Message")

                    expect(alertPresenting.presenterMock.showReceivedArguments?.title) == ""
                }
            }

            when("message is nil") {
                it("should present an alert with empty message") {
                    presentAlert(in: alertPresenting, title: "Title", message: nil)

                    expect(alertPresenting.presenterMock.showReceivedArguments?.message) == ""
                }
            }
        }
    }

}
