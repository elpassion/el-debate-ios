import Alamofire
@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

class VoteServiceSpec: QuickSpec {

    override func spec() {
        describe("VoteService") {
            var requestExecutor: RequestExecutingMock!
            var voteService: VoteService!
            var URL: URLProvider!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                URL = URLProvider()
                voteService = VoteService(requestExecutor: requestExecutor, URLProvider: URL)
            }

            afterEach {
                voteService = nil
                requestExecutor = nil
                URL = nil
            }

            describe("vote") {
                let answer = Answer(identifier: 12, value: "Yes", type: .positive)

                context("api request success") {
                    beforeEach {
                        requestExecutor.postReturnValue = VoteResponseJSONMock()
                    }

                    it("executes the success block") {
                        var answerParam: Answer?
                        _ = voteService.vote(authToken: "token", answer: answer).then { answerResult in
                            answerParam = answerResult
                        }

                        expect(answerParam).toEventuallyNot(beNil())
                    }
                }

                context("when voting too fast") {
                    beforeEach {
                        let error = VoteResponseErrorMock()
                        error.errorJSON = ["status": "request_limit_reached"]
                        error.error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 429))
                        requestExecutor.postReturnValue = error
                    }

                    it("returns throttling error") {
                        var throttleError = false

                        voteService.vote(authToken: "token", answer: answer).catch { errorResult in
                            if case RequestError.throttling = errorResult {
                                throttleError = true
                            }
                        }

                        expect(throttleError).toEventually(beTrue())
                    }
                }

                context("api request error") {
                    beforeEach {
                        requestExecutor.postReturnValue = VoteResponseErrorMock()
                    }

                    it("executes the error block") {
                        var error: Error?

                        voteService.vote(authToken: "token", answer: answer).catch { errorResult in
                            error = errorResult
                        }
                        expect(error).toNotEventually(beNil())
                    }
                }
            }
        }
    }
}
