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
                requestExecutor.postReturnValue = LoginResponseJSONMock()
                apiClient = ApiClient(requestExecutor: requestExecutor)
            }

            describe("login") {
                it("returns the authToken") {
                    var authToken: String? = nil
                    apiClient.login(pinCode: "654321") { authTokenResult in
                        authToken = authTokenResult
                    }

                    expect(authToken).toEventually(equal("123456"))
                }
            }
        }
    }
}
