@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class CommentControllerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("CommentController") {
            var sut: CommentController!
            var apiClient: APIProviderStub!
            var inputPresenter: InputAlertPresenterMock!

            beforeEach {
                apiClient = APIProviderStub()
                inputPresenter = InputAlertPresenterMock()
                sut = CommentController(voteContext: VoteContext.testDefault,
                                        apiClient: apiClient,
                                        inputAlertPresenter: inputPresenter)
            }

            describe("after view has appeared") {
                beforeEach {
                    sut.viewDidAppear(true)
                }

                it("should show input alert") {
                    expect(inputPresenter.receivedController) == sut
                }

                it("should show input alert with correct configuration") {
                    expect(inputPresenter.receivedConfiguration?.title).to(beNil())
                    expect(inputPresenter.receivedConfiguration?.message) == "Add a comment"
                    expect(inputPresenter.receivedConfiguration?.inputPlaceholder) == "Comment"
                    expect(inputPresenter.receivedConfiguration?.okTitle) == "Send"
                    expect(inputPresenter.receivedConfiguration?.cancelTitle) == "Cancel"
                }
            }

            describe("after comment is specified") {
                beforeEach {
                    inputPresenter.returnValue = Promise(value: "The comment")
                    sut.viewDidAppear(true)
                }

                it("should invoke a comment API method") {
                    expect(apiClient.commentContext?.username).toEventually(equal(VoteContext.testDefault.username))
                    expect(apiClient.commentContext?.authToken).toEventually(equal(VoteContext.testDefault.authToken))
                    expect(apiClient.commentText).toEventually(equal("The comment"))
                }

                it("should dismiss itself") {
                    var dismissed = false

                    sut.doDismiss = {
                        dismissed = true
                    }

                    expect(dismissed).toEventually(beTrue())
                }
            }

            describe("when a nil comment is added") {
                beforeEach {
                    inputPresenter.returnValue = Promise(value: nil)
                    sut.viewDidAppear(true)
                }

                it("should not invoke a comment API method") {
                    expect(apiClient.commentText).toEventually(beNil())
                }

                it("should dismiss itself") {
                    var dismissed = false

                    sut.doDismiss = {
                        dismissed = true
                    }

                    expect(dismissed).toEventually(beTrue())
                }
            }
        }
    }

}
