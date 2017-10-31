@testable import ELDebateFramework
import PromiseKit

class LoginServiceStub: LoginServiceProtocol {

    var credentials: LoginCredentials?
    var authenticationToken = "12"

    func login(credentials: LoginCredentials) -> Promise<String> {
        self.credentials = credentials
        return Promise(value: authenticationToken)
    }
}
