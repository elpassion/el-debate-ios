@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class CommentControllerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("CommentController") {
            var sut: CommentViewController!
            var apiClient: APIProviderStub!

            beforeEach {
                apiClient = APIProviderStub()
                sut = CommentController(voteContext: VoteContext.testDefault,
                                        apiClient: apiClient)
            }

            describe("after view has appeared") {
                beforeEach {
                    sut.viewDidAppear(true)
                }

            }
        }
    }

}
