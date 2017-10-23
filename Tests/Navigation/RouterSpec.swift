// swiftlint:disable function_body_length

@testable import ELDebateFramework
import Nimble
import Quick
import UIKit

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
                it("should create a view controller passing a vote context") {
                    var voteContextForAnswerController: VoteContext?

                    sut.go(to: .answer(voteContext: VoteContext.testDefault))

                    if case let .some(.answer(voteContext)) = controllerFactory.lastType {
                        voteContextForAnswerController = voteContext
                    }

                    expect(voteContextForAnswerController).toNot(beNil())
                    expect(voteContextForAnswerController?.debate.topic) == "test_debate_topic"
                }

                it("should push answer view controller on stack") {
                    sut.go(to: .answer(voteContext: VoteContext.testDefault))

                    expect(navigationController.viewControllers).to(containElementSatisfying({ controller in
                        controller == controllerFactory.answerProvider.controller
                    }))
                }

                it("should configure controller") {
                    sut.go(to: .answer(voteContext: VoteContext.testDefault))

                    expect(controllerConfigurator.configureReceivedArguments?.controller).to(be(
                        controllerFactory.answerProvider))
                    expect(controllerConfigurator.configureReceivedArguments?.router).to(be(sut))
                }
            }

            describe("routing to comment screen") {
                it("should push comment controller on stack") {
                    sut.go(to: .comment(voteContext: VoteContext.testDefault))

                    expect(controllerConfigurator.configureReceivedArguments?.controller).to(be(
                        controllerFactory.commentProvider))
                    expect(controllerConfigurator.configureReceivedArguments?.router).to(be(sut))
                }
            }

            describe("reset") {
                beforeEach {
                    let controllers: [UIViewController] = [UIViewController(), UIViewController(), UIViewController()]
                    navigationController.setViewControllers(controllers, animated: false)
                }

                it("should reset navigation controller stack") {
                    sut.reset(to: .pinEntry)

                    expect(sut.navigator.viewControllers.count).toEventually(equal(1))
                    expect(sut.navigator.viewControllers).toEventually(containElementSatisfying({ controller in
                        controller == controllerFactory.pinEntryProvider.controller
                    }))
                }
            }
        }
    }

}
