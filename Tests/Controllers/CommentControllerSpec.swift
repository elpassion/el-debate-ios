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
            }
        }
    }

}
