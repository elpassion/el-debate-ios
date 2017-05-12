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
            var controllerConfigurator: ControllerConfiguringMock!
            var sut: Router!

            beforeEach {
                navigationController = UINavigationController()
                controllerFactory = ControllerFactoryMock()
                controllerConfigurator = ControllerConfiguringMock()
                sut = Router(navigator: navigationController,
                             controllerFactory: controllerFactory,
                             controllerConfigurator: controllerConfigurator)
            }

            describe("routing to pin entry screen") {
                it("should push view controller on stack") {
                    sut.go(to: .pinEntry)

                    expect(controllerFactory.lastType).to(equal(ControllerType.pinEntry))
                    expect(navigationController.viewControllers).to(containElementSatisfying({ controller in
                        controller == controllerFactory.pinEntryProvider.controller
                    }))
                }

                it("should configure controller") {
                    sut.go(to: .pinEntry)

                    expect(controllerConfigurator.configureReceivedArguments?.controller).to(be(
                        controllerFactory.pinEntryProvider))
                    expect(controllerConfigurator.configureReceivedArguments?.router).to(be(sut))
                }
            }

            describe("routing to answer screen") {
                it("should push answer view controller on stack") {
                    sut.go(to: .answer)

                    expect(controllerFactory.lastType).to(equal(ControllerType.answer))
                    expect(navigationController.viewControllers).to(containElementSatisfying({ controller in
                        controller == controllerFactory.answerProvider.controller
                    }))
                }

                it("should configure controller") {
                    sut.go(to: .answer)

                    expect(controllerConfigurator.configureReceivedArguments?.controller).to(be(
                        controllerFactory.answerProvider))
                    expect(controllerConfigurator.configureReceivedArguments?.router).to(be(sut))
                }
            }
        }
    }
}
