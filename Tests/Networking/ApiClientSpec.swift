//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import PromiseKit
import Quick

class ApiClientSpec: QuickSpec {

    override func spec() {
        describe("ApiClient") {
            var apiClient: ApiClient!
            var requestExecutor: RequestExecutingMock!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                apiClient = ApiClient(requestExecutor: requestExecutor,
                                      authTokenDeserializer: Deserializer(AuthTokenDeserializer()),
                                      debateDeserializer: DebateDeserializer.build()
                )
            }

            describe("login") {
                context("request success") {
                    beforeEach {
                        requestExecutor.postReturnValue = LoginResponseJSONMock()
                    }

                    it("returns the authToken") {
                        var authToken: String? = nil
                        _ = apiClient.login(pinCode: "654321").then { authTokenResult in
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
                        var error: Error? = nil

                        apiClient.login(pinCode: "654321").then { _ in
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
                        var debate: Debate? = nil
                        _ = apiClient.fetchDebate(authToken: "auth_token_value").then { debateResult in
                            debate = debateResult
                        }

                        expect(debate?.topic).toEventually(equal("debate_topic"))
                    }
                }
            }

            describe("vote") {
                let answer = Answer(identifier: 12, value: "Yes")

                context("api request success") {
                    beforeEach {
                        requestExecutor.postReturnValue = VoteResponseJSONMock()
                    }

                    it("executes the success block") {
                        var success: Bool? = nil
                        _ = apiClient.vote(authToken: "token", answer: answer).then { successResult in
                            success = successResult
                        }

                        expect(success).toEventually(equal(true))
                    }
                }

                context("api request error") {
                    beforeEach {
                        requestExecutor.postReturnValue = VoteResponseErrorMock()
                    }
                    
                    it("executes the error block") {
                        var error: Error? = nil

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
