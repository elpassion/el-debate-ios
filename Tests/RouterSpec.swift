//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class RouterSpec: QuickSpec {

    override func spec() {
        describe("Router") {
            var navigationController: UINavigationController!
            var controllerFactory: ControllerFactoryMock!
            var sut: Router!

            beforeEach {
                navigationController = UINavigationController()
                controllerFactory = ControllerFactoryMock()
                sut = Router(navigator: navigationController, controllerFactory: controllerFactory)
            }

            describe("routing to pin entry screen") {
                it("should push view controller on stack") {
                    sut.go(to: .pinEntry)

                    expect(controllerFactory.lastType).to(equal(ControllerType.pinEntry))
                    expect(navigationController.viewControllers).to(containElementSatisfying({ controller in
                        controller == controllerFactory.pinEntryProvider.controller
                    }))
                }
            }

            describe("login action on pin entry screen") {
                it("should navigate to answer screen") {
                    sut.go(to: .pinEntry)

                    controllerFactory.pinEntryProvider.onSuccessfulLogin?("auth_token")

                    expect(navigationController.viewControllers.count).toEventually(equal(2))
                }
            }
        }
    }
}
