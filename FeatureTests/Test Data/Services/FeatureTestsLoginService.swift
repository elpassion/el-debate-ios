@testable import ELDebateFramework
import PromiseKit

class FeatureTestsLoginService: LoginServiceProtocol {

    func login(credentials: LoginCredentials) -> Promise<String> {
        return Promise(value: "auth_token")
    }

}
