@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

internal class AlertPresenterSpec: QuickSpec {

    // swiftlint:disable function_body_length
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

        describe("AlertPresenter") {
            var controller: PresentControllerSpy!
            var alertFactory: AlertFactoryMock!
            var sut: AlertPresenter!

            beforeEach {
                controller = PresentControllerSpy()
                alertFactory = AlertFactoryMock()
                sut = AlertPresenter()
            }

            when("showing alert") {
                var result: Promise<Bool>!

                beforeEach {
                    result = sut.show(in: controller, title: "Title", message: "Message", alertFactory: alertFactory)
                }

                it("should present the alert in passed controller") {
                    expect(controller.hasPresentedController) == alertFactory.returnedAlert
                }

                it("should create the alert with proper title and message") {
                    expect(alertFactory.lastConfiguration?.title) == "Title"
                    expect(alertFactory.lastConfiguration?.message) == "Message"
                }

                it("should create the alert with single OK action") {
                    let action = alertFactory.lastConfiguration?.actions.first

                    expect(alertFactory.lastConfiguration?.actions.count) == 1
                    expect(action?.title) == "Ok"
                    expect(action?.style) == UIAlertActionStyle.default
                }

                it("should return a promise that returns true if ok is clicked") {
                    var okTriggered = false
                    _ = result.then { okTriggered = $0 }

                    alertFactory.lastConfiguration?.actions.first?.handler?()

                    expect(okTriggered).toEventually(beTrue())
                }
            }
        }
    }

}
