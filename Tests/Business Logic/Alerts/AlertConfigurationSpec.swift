//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick

internal class AlertConfigurationSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("AlertTextFieldConfiguration") {
            describe("equality") {
                when("placeholders differ") {
                    it("should return false") {
                        let lhs = AlertTextFieldConfiguration(placeholder: "p1")
                        let rhs = AlertTextFieldConfiguration(placeholder: "p2")

                        expect(lhs) != rhs
                    }
                }

                when("configurations are the same") {
                    it("should return true") {
                        let lhs = AlertTextFieldConfiguration(placeholder: "placeholder")
                        let rhs = AlertTextFieldConfiguration(placeholder: "placeholder")

                        expect(lhs) == rhs
                    }
                }
            }
        }

        describe("AlertActionConfiguration") {
            describe("equality") {
                when("titles differ") {
                    it("should return false") {
                        let lhs = AlertActionConfiguration(title: "t1", style: .cancel, handler: nil)
                        let rhs = AlertActionConfiguration(title: "t2", style: .cancel, handler: nil)

                        expect(lhs) != rhs
                    }
                }

                when("styles differ") {
                    it("should return false") {
                        let lhs = AlertActionConfiguration(title: "title", style: .cancel, handler: nil)
                        let rhs = AlertActionConfiguration(title: "title", style: .destructive, handler: nil)

                        expect(lhs) != rhs
                    }
                }

                when("configurations are the same") {
                    it("should return true") {
                        let lhs = AlertActionConfiguration(title: "title", style: .default, handler: nil)
                        let rhs = AlertActionConfiguration(title: "title", style: .default, handler: nil)

                        expect(lhs) == rhs
                    }
                }
            }
        }

        describe("AlertConfiguration") {
            describe("equality") {
                when("titles differ") {
                    it("should return false") {
                        let lhs = AlertConfiguration(title: "t1", message: "message", actions: [], textFields: [])
                        let rhs = AlertConfiguration(title: "t2", message: "message", actions: [], textFields: [])

                        expect(lhs) != rhs
                    }
                }

                when("messages differ") {
                    it("should return false") {
                        let lhs = AlertConfiguration(title: "title", message: "m1", actions: [], textFields: [])
                        let rhs = AlertConfiguration(title: "title", message: "m2", actions: [], textFields: [])

                        expect(lhs) != rhs
                    }
                }

                when("actions differ") {
                    it("should return false") {
                        let action = AlertActionConfiguration(title: "action", style: .destructive, handler: nil)
                        let lhs = AlertConfiguration(title: "title", message: "message",
                                                     actions: [action], textFields: [])
                        let rhs = AlertConfiguration(title: "title", message: "message",
                                                     actions: [], textFields: [])

                        expect(lhs) != rhs
                    }
                }

                when("textfields differ") {
                    it("should return false") {
                        let textField = AlertTextFieldConfiguration(placeholder: "placeholder")
                        let lhs = AlertConfiguration(title: "title", message: "message",
                                                     actions: [], textFields: [textField])
                        let rhs = AlertConfiguration(title: "title", message: "message",
                                                     actions: [], textFields: [])

                        expect(lhs) != rhs
                    }
                }

                when("configurations are the same") {
                    it("should return false") {
                        let action = AlertActionConfiguration(title: "action", style: .destructive, handler: nil)
                        let textField = AlertTextFieldConfiguration(placeholder: "placeholder")
                        let lhs = AlertConfiguration(title: "title", message: "message",
                                                     actions: [action], textFields: [textField])
                        let rhs = AlertConfiguration(title: "title", message: "message",
                                                     actions: [action], textFields: [textField])

                        expect(lhs) == rhs
                    }
                }
            }
        }
    }

}
