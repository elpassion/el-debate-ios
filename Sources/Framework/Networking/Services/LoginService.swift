import Alamofire
import Foundation
import PromiseKit

protocol LoginServiceProtocol {
    func login(credentials: LoginCredentials) -> Promise<String>
}

class LoginService: LoginServiceProtocol {

    init(requestExecutor: RequestExecuting,
         authTokenDeserializer: Deserializer<String>,
         URLProvider: URLProviding) {

        self.requestExecutor = requestExecutor
        self.authTokenDeserializer = authTokenDeserializer
        self.URLProvider = URLProvider
    }

    func login(credentials: LoginCredentials) -> Promise<String> {
        let jsonResponse = requestExecutor.post(
            url: "\(URLProvider.url)/api/login",
            body: ["code": credentials.pin],
            headers: nil
        )

        return request(with: jsonResponse.json, deserializedBy: self.authTokenDeserializer)
    }

    // MARK: - Private

    private let requestExecutor: RequestExecuting
    private let authTokenDeserializer: Deserializer<String>
    private let URLProvider: URLProviding
}
