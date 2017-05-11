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
            describe("routing to pin entry screen") {
                it("should push view controller on stack") {
                    let navigationController = UINavigationController()
                    let controllerFactory = ControllerFactoryMock()
                    let sut = Router(navigator: navigationController, controllerFactory: controllerFactory)

                    sut.go(to: .pinEntry)

                    expect(controllerFactory.lastType).to(equal(ControllerType.pinEntry))
                    expect(navigationController.viewControllers).to(containElementSatisfying({ controller in
                        controller == controllerFactory.provider.controller
                    }))
                }
            }
        }
    }
}
