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

            describe("configure method") {
                context("when configuring pin controller") {
                    it("should navigate to answer passing debate") {
                        var passedDebate: Debate?
                        let pinControllerProvider = PinEntryControllerMockProvider()

                        sut.configure(controller: pinControllerProvider, with: routerMock)
                        pinControllerProvider.onDebateLoaded?(Debate.testDefault)

                        if case let .some(.answer(debate)) = routerMock.lastRoute {
                            passedDebate = debate
                        }

                        expect(passedDebate).toNot(beNil())
                        expect(passedDebate?.topic).to(equal("test_debate_topic"))
                    }
                }
            }
        }
    }
}
