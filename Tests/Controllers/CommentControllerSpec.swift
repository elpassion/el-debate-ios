@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class CommentControllerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("CommentController") {
            var sut: CommentViewControllerMock!
            var fetchCommentServiceStub: FetchCommentsServiceStub!
            var commentsWebSocketStub: CommentsWebSocketStub!
            var commentPresenter: CommentPresenter!

            beforeEach {
                fetchCommentServiceStub = FetchCommentsServiceStub()
                commentsWebSocketStub = CommentsWebSocketStub()
                commentPresenter = CommentPresenter()

                sut = CommentViewControllerMock(fetchCommentsService: fetchCommentServiceStub,
                                                commentsWebSocketService: commentsWebSocketStub,
                                                commentPresenter: commentPresenter,
                                                voteContext: VoteContext.testDefault)
            }

            afterEach {

            }

            describe("after view has appeared") {
                beforeEach {
                    sut.viewDidLoad()
                }

                it("should set title") {
                    expect(sut.title) == "Live Chat Feed"
                }

                it ("should have a valid snapshot") {
                    sut.view.frame = UIScreen.main.bounds

                    expect(sut.view).to(recordDeviceAgnosticSnapshot())
                }
            }
        }
    }

}
