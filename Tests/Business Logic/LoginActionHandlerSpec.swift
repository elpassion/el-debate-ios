//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class LoginActionHandlerSpec: QuickSpec {

    override func spec() {
        describe("LoginActionHandler") {
            var apiProviderStub: APIProviderStub!
            var tokenStorage: AuthTokenStorageStub!
            var loginActionHandler: LoginActionHandler!

            beforeEach {
                apiProviderStub = APIProviderStub()
                apiProviderStub.authenticationToken = "auth_token_from_service"
                tokenStorage = AuthTokenStorageStub()
                loginActionHandler = LoginActionHandler(apiClient: apiProviderStub, tokenStorage: tokenStorage)
            }

            describe("login") {
                context("when token for pin exists in storage") {
                    beforeEach {
                        tokenStorage.hasTokenReturnValue = true
                        tokenStorage.getTokenReturnValue = "auth_token_from_storage"
                    }

                    it("should return token from storage") {
                        var authToken: String? = nil
                        _ = loginActionHandler.login(withPinCode: "in_storage").then { authTokenResult in
                            authToken = authTokenResult
                        }

                        expect(authToken).toEventually(equal("auth_token_from_storage"))
                    }
                }

                context("when token for pin does not exist in storage") {
                    beforeEach {
                        tokenStorage.hasTokenReturnValue = false
                        tokenStorage.getTokenReturnValue = nil
                    }

                    it("should return token from service") {
                        var authToken: String? = nil
                        _ = loginActionHandler.login(withPinCode: "not_in_storage").then { authTokenResult in
                            authToken = authTokenResult
                        }

                        expect(authToken).toEventually(equal("auth_token_from_service"))
                    }

                    it("should store pin and auth code in storage") {
                        _ = loginActionHandler.login(withPinCode: "not_in_storage")

                        expect(tokenStorage.lastSavedPin).toEventually(equal("not_in_storage"))
                        expect(tokenStorage.lastSavedToken).toEventually(equal("auth_token_from_service"))
                    }
                }

                context("when token storage throws an exception") {
                    beforeEach {
                        apiProviderStub = APIProviderStub()
                        apiProviderStub.authenticationToken = "auth_token_from_service"
                        loginActionHandler = LoginActionHandler(apiClient: apiProviderStub,
                                                                tokenStorage: ThrowingAuthTokenStorageStub())
                    }

                    it("should propagate it") {
                        var error: Error?

                        _ = loginActionHandler.login(withPinCode: "pin_code").catch {
                            error = $0
                        }

                        expect(error).toEventuallyNot(beNil())
                    }
                }
            }
        }
    }
}
