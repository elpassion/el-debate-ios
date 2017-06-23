//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick
import UIKit

internal class AlertFactorySpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("AlertFactory") {
            var sut: AlertFactory!

            beforeEach {
                sut = AlertFactory()
            }

            when("making an alert") {
                var alert: UIAlertController!

                beforeEach {
                    let configuration = AlertConfiguration(
                        title: "Title",
                        message: "Message",
                        actions: [],
                        textFields: [])

                    alert = sut.makeAlert(with: configuration)
                }

                it("should set title") {
                    expect(alert.title) == "Title"
                }

                it("should set message") {
                    expect(alert.message) == "Message"
                }

                it("should set preferred style to alert") {
                    expect(alert.preferredStyle) == UIAlertControllerStyle.alert
                }
            }

            when("making an alert with actions") {
                it("should configure actions") {
                    let action = AlertActionConfiguration(title: "1", style: .default) {}
                    let otherAction = AlertActionConfiguration(title: "2", style: .cancel) {}
                    let configuration = AlertConfiguration(title: nil,
                                                           message: nil,
                                                           actions: [action, otherAction],
                                                           textFields: [])

                    let alert = sut.makeAlert(with: configuration)

                    expect(alert.actions.count) == 2
                    expect(alert.actions.first?.title) == "1"
                    expect(alert.actions.first?.style) == UIAlertActionStyle.default
                    expect(alert.actions.last?.title) == "2"
                    expect(alert.actions.last?.style) == UIAlertActionStyle.cancel
                }
            }

            when("making an alert with textfields") {
                it("should configure textfields") {
                    let textField = AlertTextFieldConfiguration(placeholder: "P1")
                    let otherTextField = AlertTextFieldConfiguration(placeholder: "P2")
                    let configuration = AlertConfiguration(title: nil,
                                                           message: nil,
                                                           actions: [],
                                                           textFields: [textField, otherTextField])

                    let alert = sut.makeAlert(with: configuration)

                    expect(alert.textFields?.count) == 2
                    expect(alert.textFields?.first?.placeholder) == "P1"
                    expect(alert.textFields?.last?.placeholder) == "P2"
                }
            }
        }
    }

}
