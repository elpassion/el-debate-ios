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
                                      authTokenDeserializer: Deserializer(AuthTokenDeserializer()),
                                      debateDeserializer: DebateDeserializer.build(),
                                      commentsDeserializer: Deserializer(CommentsDeserializer(jsonDecoder: JSONDecoder())))
            }

            describe("login") {
                context("request success") {
                    beforeEach {
                        requestExecutor.postReturnValue = LoginResponseJSONMock()
                    }

                    it("passes correct parameters to login service") {
                        let credentials = LoginCredentials(pin: "90912")

                        _ = apiClient.login(credentials: credentials)

                        expect(requestExecutor.postReceivedArguments?.body?["code"] as? String) == "90912"
                    }

                    it("returns the authToken") {
                        let credentials = LoginCredentials(pin: "654321")
                        var authToken: String? = nil

                        _ = apiClient.login(credentials: credentials).then { authTokenResult in
                            authToken = authTokenResult
                        }

                        expect(authToken).toEventually(equal("123456"))
                    }
                }

                context("request error") {
                    beforeEach {
                        requestExecutor.postReturnValue = LoginResponseErrorMock()
                    }

                    it("executes the only error block") {
                        let credentials = LoginCredentials(pin: "654321")
                        var error: Error? = nil

                        apiClient.login(credentials: credentials).then { _ in
                            fatalError("This should never happen :D")
                        }.catch { errorResult in
                            error = errorResult
                        }

                        expect(error).toNotEventually(beNil())
                    }
                }

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
