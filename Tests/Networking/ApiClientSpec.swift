//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
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
                beforeEach {
                    requestExecutor.postReturnValue = LoginResponseJSONMock()
                }

                it("returns the authToken") {
                    var authToken: String? = nil
                    apiClient.login(pinCode: "654321") { authTokenResult in
                        authToken = authTokenResult
                    }

                    expect(authToken).toEventually(equal("123456"))
                }
            }

            describe("fetchDebate") {
                beforeEach {
                    requestExecutor.getReturnValue = FetchDebateResponseJSONMock()
                }

                it("returns deserialized Debate object") {
                    var debate: Debate? = nil
                    apiClient.fetchDebate(authToken: "auth_token_value") { debateResult in
                        debate = debateResult
                    }

                    expect(debate?.topic).toEventually(equal("debate_topic"))
                }
            }
        }
    }
}
