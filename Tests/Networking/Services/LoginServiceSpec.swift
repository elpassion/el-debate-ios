import Alamofire
@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

class LoginServiceSpec: QuickSpec {

    override func spec() {
        describe("LoginService") {
            var requestExecutor: RequestExecutingMock!
            var loginService: LoginService!
            var URL: URLProvider!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                URL = URLProvider()
                loginService = LoginService(requestExecutor: requestExecutor,
                                            authTokenDeserializer: Deserializer(AuthTokenDeserializer()),
                                            URLProvider: URL)
            }

            afterEach {
                requestExecutor = nil
                loginService = nil
                URL = nil
            }

            describe("login") {
                context("request success") {
                    beforeEach {
                        requestExecutor.postReturnValue = LoginResponseJSONMock()
                    }

                    it("passes correct parameters to login service") {
                        let credentials = LoginCredentials(pin: "90912")

                        _ = loginService.login(credentials: credentials)

                        expect(requestExecutor.postReceivedArguments?.body?["code"] as? String) == "90912"
                    }

                    it("returns the authToken") {
                        let credentials = LoginCredentials(pin: "654321")
                        var authToken: String? = nil

                        _ = loginService.login(credentials: credentials).then { authTokenResult in
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

                        loginService.login(credentials: credentials).then { _ in
                            fatalError("This should never happen :D")
                        }.catch { errorResult in
                            error = errorResult
                        }

                        expect(error).toNotEventually(beNil())
                    }
                }
            }
        }
    }

}
