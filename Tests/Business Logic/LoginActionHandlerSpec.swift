//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick

class LoginActionHandlerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("LoginActionHandler") {
            var apiProviderStub: APIProviderStub!
            var tokenStorage: AuthTokenStorageStub!
            var formValidator: PinFormValidatorMock!
            var sut: LoginActionHandler!

            beforeEach {
                apiProviderStub = APIProviderStub()
                apiProviderStub.authenticationToken = "auth_token_from_service"
                tokenStorage = AuthTokenStorageStub()
                formValidator = PinFormValidatorMock()
                sut = LoginActionHandler(apiClient: apiProviderStub,
                                         tokenStorage: tokenStorage,
                                         formValidator: formValidator)
            }

            describe("login") {
                context("when token for pin exists in storage") {
                    beforeEach {
                        tokenStorage.hasTokenReturnValue = true
                        tokenStorage.getTokenReturnValue = "auth_token_from_storage"
                    }

                    it("should use token from storage") {
                        _ = sut.login(with: LoginCredentials(pin: "in_storage", username: "user"))

                        expect(apiProviderStub.debateAuthToken).toEventually(equal("auth_token_from_storage"))
                    }
                }

                context("when token for pin does not exist in storage") {
                    beforeEach {
                        tokenStorage.hasTokenReturnValue = false
                        tokenStorage.getTokenReturnValue = nil
                    }

                    it("should use token from service") {
                        _ = sut.login(with: LoginCredentials(pin: "not_in_storage", username: "user"))

                        expect(apiProviderStub.debateAuthToken).toEventually(equal("auth_token_from_service"))
                    }

                    it("should store pin and auth code in storage") {
                        _ = sut.login(with: LoginCredentials(pin: "not_in_storage", username: "user"))

                        expect(tokenStorage.lastSavedPin).toEventually(equal("not_in_storage"))
                        expect(tokenStorage.lastSavedToken).toEventually(equal("auth_token_from_service"))
                    }
                }

                context("when token storage throws an exception") {
                    beforeEach {
                        apiProviderStub = APIProviderStub()
                        apiProviderStub.authenticationToken = "auth_token_from_service"
                        sut = LoginActionHandler(apiClient: apiProviderStub,
                                                 tokenStorage: ThrowingAuthTokenStorageStub(),
                                                 formValidator: formValidator)
                    }

                    it("should propagate it") {
                        var error: Error?

                        _ = sut.login(with: LoginCredentials(pin: "pin_code", username: "user")).catch { loginError in
                            error = loginError
                        }

                        expect(error).toEventuallyNot(beNil())
                    }
                }

                it("should return VoteContext from API client") {
                    var voteContext: VoteContext?

                    _ = sut.login(with: LoginCredentials(pin: "pin_code", username: "user")).then { result in
                        voteContext = result
                    }

                    expect(voteContext?.debate.topic).toEventually(equal("test_debate_topic"))
                }
            }
        }
    }
}
