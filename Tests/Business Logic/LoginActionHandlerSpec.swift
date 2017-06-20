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
                context("when credential validation fails") {
                    beforeEach {
                        formValidator.error = PinCodeValidatorError.missing
                    }

                    it("should propagate the error") {
                        var errorPropagated = false

                        _ = sut.login(with: LoginCredentials(pin: "pin", username: "user")).catch { error in
                            if case PinCodeValidatorError.missing = error {
                                errorPropagated = true
                            }
                        }

                        expect(errorPropagated).toEventually(beTrue())
                    }
                }

                it("should pass correct arguments to a validator") {
                    _ = sut.login(with: LoginCredentials(pin: "val_pin", username: "val_user"))

                    expect(formValidator.lastPin) == "val_pin"
                    expect(formValidator.lastUsername) == "val_user"
                }

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

                    it("should pass correct arguments to login method") {
                        _ = sut.login(with: LoginCredentials(pin: "123", username: "qwerty"))

                        expect(apiProviderStub.credentials?.pin).toEventually(equal("123"))
                        expect(apiProviderStub.credentials?.username).toEventually(equal("qwerty"))
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

                describe("returned vote context") {
                    var voteContext: VoteContext?

                    beforeEach {
                        _ = sut.login(with: LoginCredentials(pin: "pin_code", username: "TheUser")).then { result in
                            voteContext = result
                        }
                    }

                    it("should have debate details returned from API client") {
                        expect(voteContext?.debate.topic).toEventually(equal("test_debate_topic"))
                        expect(voteContext?.debate.positiveAnswer.identifier).toEventually(equal(1))
                        expect(voteContext?.debate.neutralAnswer.identifier).toEventually(equal(2))
                        expect(voteContext?.debate.negativeAnswer.identifier).toEventually(equal(3))
                    }

                    it("should have username passed with form data") {
                        expect(voteContext?.username).toEventually(equal("TheUser"))
                    }
                }
            }
        }
    }
}
