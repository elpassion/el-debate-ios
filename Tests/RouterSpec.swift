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
                    let sut = Router(navigator: navigationController)

                    sut.go(to: .pinEntry)

                    expect(navigationController.viewControllers).to(containElementSatisfying({ controller in
                        controller.isKind(of: PinEntryViewController.self)
                    }))
                }
            }
        }
    }

}
