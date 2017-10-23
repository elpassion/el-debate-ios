import Alamofire
@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

class FetchCommentsServiceSpec: QuickSpec {

    override func spec() {
        describe("FetchCommentsService") {
            var requestExecutor: RequestExecutingMock!
            var fetchCommentsService: FetchCommentsService!
            var URL: URLProvider!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                URL = URLProvider()
                fetchCommentsService = FetchCommentsService(requestExecutor: requestExecutor,
                                                            commentsDeserializer: Deserializer(CommentsDeserializer(jsonDecoder: JSONDecoder())),
                                                            URLProvider: URL)
            }

            afterEach {
                requestExecutor = nil
                URL = nil
                fetchCommentsService = nil
            }

            describe("fetchDebate") {
                context("debate is NOT closed") {
                    beforeEach {
                        requestExecutor.getReturnValue = FetchCommentsJSONMock()
                    }

                    it("returns deserialized comments for NOT closed debate") {
                        var comments: Comments?
                        _ = fetchCommentsService.fetchComments(authToken: "").then { commentsResult in
                            comments = commentsResult
                        }
                        expect(comments?.debateClosed).toEventually(equal(false))
                    }
                }
                context("debate is closed") {
                    beforeEach {
                        requestExecutor.getReturnValue = DebateClosedFetchCommentsJSONMock()
                    }

                    it("returns deserialized comments for closed debate") {
                        var comments: Comments?
                        _ = fetchCommentsService.fetchComments(authToken: "").then { commentsResult in
                            comments = commentsResult
                        }
                        expect(comments?.debateClosed).toEventually(equal(true))
                    }
                }
            }
        }
    }
}
