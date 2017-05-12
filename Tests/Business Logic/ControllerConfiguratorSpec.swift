//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class ControllerConfiguratorSpec: QuickSpec {

    override func spec() {
        var routerMock: RouterMock!
        var sut: ControllerConfigurator!

        describe("ControllerConfigurator") {
            beforeEach {
                routerMock = RouterMock()
                sut = ControllerConfigurator()
            }

            describe("configuration") {
                context("when configuring pin controller") {
                    it("should configure login action to navigate to answer") {
                        var navigatedToAnswer = false
                        let pinControllerProvider = PinEntryControllerMockProvider()

                        sut.configure(controller: pinControllerProvider, with: routerMock)
                        pinControllerProvider.onSuccessfulLogin?("auth_token")

                        if case .some(.answer) = routerMock.lastRoute {
                            navigatedToAnswer = true
                        }

                        expect(navigatedToAnswer).to(beTrue())
                    }
                }
            }
        }
    }
}
