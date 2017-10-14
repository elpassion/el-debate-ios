import Alamofire
@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

class ApiClientSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("ApiClient") {
            var apiClient: ApiClient!
            var requestExecutor: RequestExecutingMock!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                apiClient = ApiClient(requestExecutor: requestExecutor,
                                      debateDeserializer: DebateDeserializer.build(),
                                      commentsDeserializer: Deserializer(CommentsDeserializer(jsonDecoder: JSONDecoder())))
            }

            describe("fetchDebate") {
                context("api request success") {
                    beforeEach {
                        requestExecutor.getReturnValue = FetchDebateResponseJSONMock()
                    }

                    it("returns deserialized Debate object") {
                        var debate: Debate?
                        _ = apiClient.fetchDebate(authToken: "auth_token_value").then { debateResult in
                            debate = debateResult
                        }

                        expect(debate?.topic).toEventually(equal("debate_topic"))
                    }
                }
            }

            describe("vote") {
                let answer = Answer(identifier: 12, value: "Yes", type: .positive)

                context("api request success") {
                    beforeEach {
                        requestExecutor.postReturnValue = VoteResponseJSONMock()
                    }

                    it("executes the success block") {
                        var answerParam: Answer?
                        _ = apiClient.vote(authToken: "token", answer: answer).then { answerResult in
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

                        apiClient.vote(authToken: "token", answer: answer).catch { errorResult in
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

                        apiClient.vote(authToken: "token", answer: answer).catch { errorResult in
                            error = errorResult
                        }
                        expect(error).toNotEventually(beNil())
                    }
                }
            }
        }
    }

}
