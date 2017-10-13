import Alamofire
import Foundation
import PromiseKit

protocol APIProviding {

    func login(credentials: LoginCredentials) -> Promise<String>
    func fetchDebate(authToken: String) -> Promise<Debate>
    func vote(authToken: String, answer: Answer) -> Promise<Answer>

}

class ApiClient: APIProviding {

    private let requestExecutor: RequestExecuting
    private let authTokenDeserializer: Deserializer<String>
    private let debateDeserializer: Deserializer<Debate>
    private let commentsDeserializer: Deserializer<Comments>
    private let apiHost: String = "https://el-debate.herokuapp.com"

    init(requestExecutor: RequestExecuting,
         authTokenDeserializer: Deserializer<String>,
         debateDeserializer: Deserializer<Debate>,
         commentsDeserializer: Deserializer<Comments>) {
        self.requestExecutor = requestExecutor
        self.authTokenDeserializer = authTokenDeserializer
        self.debateDeserializer = debateDeserializer
        self.commentsDeserializer = commentsDeserializer
    }

    func login(credentials: LoginCredentials) -> Promise<String> {
        let jsonResponse = requestExecutor.post(
            url: "\(apiHost)/api/login",
            body: ["code": credentials.pin],
            headers: nil
        )

        return request(with: jsonResponse.json, deserializedBy: self.authTokenDeserializer)
    }

    func fetchDebate(authToken: String) -> Promise<Debate> {
        let jsonResponse = requestExecutor.get(
            url: "\(apiHost)/api/debate",
            headers: ["Authorization": authToken]
        )

        return request(with: jsonResponse.json, deserializedBy: self.debateDeserializer)
    }

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        let response = requestExecutor.post(
            url: "\(apiHost)/api/vote",
            body: ["id": answer.identifier],
            headers: ["Authorization": authToken]
        )

        return Promise(requestExecutor: response.maybeJson) { _ in answer }
            .recover { error -> Promise<Answer> in
                if case let AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: code)) = error,
                    code == 429 {
                    return Promise(error: RequestError.throttling)
                } else {
                    return Promise(error: error)
                }
            }
    }

    func fetchComments(authToken: String) -> Promise<Comments> {
        let jsonResponse = requestExecutor.get(
            url: "\(apiHost)/api/comments",
            headers: ["Authorization": authToken]
        )

        return request(with: jsonResponse.json, deserializedBy: self.commentsDeserializer)
    }

}
