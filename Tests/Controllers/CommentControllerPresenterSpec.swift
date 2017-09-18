@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class CommentControllerPresenterSpec: QuickSpec {

    override func spec() {
        describe("CommentControllerPresenter") {
            var sut: CommentControllerPresenter!
            var controllerFactory: ControllerFactoryMock!

            beforeEach {
                controllerFactory = ControllerFactoryMock()
                sut = CommentControllerPresenter(controllerFactory: controllerFactory)
            }

            describe("present") {
                var presentedInController: ChildControllerSpy!

                beforeEach {
                    presentedInController = ChildControllerSpy()
                    sut.present(in: presentedInController, with: VoteContext.testDefault)
                }

                it("should add a child view controller") {
                    expect(presentedInController.addedChild) == controllerFactory.commentProvider.controller
                }

                it("should create a comment with vote context") {
                    let context = controllerFactory.lastContext

                    expect(context?.authToken) == VoteContext.testDefault.authToken
                    expect(context?.debate.topic) == VoteContext.testDefault.debate.topic
                }

                it("should call will move to parent on alert") {
                    let commentSpy = controllerFactory.commentProvider.controller as? ChildControllerSpy

                    expect(commentSpy?.willMoveCalledTo) == presentedInController
                }

                it("should call did move to parent on alert") {
                    let commentSpy = controllerFactory.commentProvider.controller as? ChildControllerSpy

                    expect(commentSpy?.didMoveCalledTo) == presentedInController
                }

                it("should add alert subview") {
                    let alertView: UIView = controllerFactory.commentProvider.controller.view

                    expect(presentedInController.view.subviews).to(contain(alertView))
                }
            }
        }
    }

}
