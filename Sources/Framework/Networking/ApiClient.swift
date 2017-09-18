import Alamofire
import Foundation
import PromiseKit

protocol APIProviding {

    func login(credentials: LoginCredentials) -> Promise<String>
    func fetchDebate(authToken: String) -> Promise<Debate>
    func vote(authToken: String, answer: Answer) -> Promise<Answer>
    func comment(_ text: String, with voteContext: VoteContext) -> Promise<Bool>

}

class ApiClient: APIProviding {

    private let requestExecutor: RequestExecuting
    private let authTokenDeserializer: Deserializer<String>
    private let debateDeserializer: Deserializer<Debate>
    private let apiHost: String = "https://el-debate.herokuapp.com"

    init(requestExecutor: RequestExecuting,
         authTokenDeserializer: Deserializer<String>,
         debateDeserializer: Deserializer<Debate>) {
        self.requestExecutor = requestExecutor
        self.authTokenDeserializer = authTokenDeserializer
        self.debateDeserializer = debateDeserializer
    }

    func login(credentials: LoginCredentials) -> Promise<String> {
        let jsonResponse = requestExecutor.post(
            url: "\(apiHost)/api/login",
            body: ["code": credentials.pin, "username": credentials.username],
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

        return Promise(requestExecutor: response.maybeJson, processor: { _ in answer })
            .recover { error -> Promise<Answer> in
                if case let AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: code)) = error,
                    code == 429 {
                    return Promise(error: RequestError.throttling)
                } else {
                    return Promise(error: error)
                }
            }
    }

    func comment(_ text: String, with voteContext: VoteContext) -> Promise<Bool> {
        let username: String = voteContext.username ?? ""
        let response = requestExecutor.post(
            url: "\(apiHost)/api/comment",
            body: ["text": text, "username": username],
            headers: ["Authorization": voteContext.authToken]
        )

        return Promise(requestExecutor: response.maybeJson, processor: { _ in true })
    }

}

private func request<T>(with executor: @escaping (@escaping (ApiResponse) -> Void) -> Void,
                        deserializedBy deserializer: Deserializer<T>) -> Promise<T> {
    return Promise(requestExecutor: executor, processor: { response in
        try deserializer.deserialize(json: response.json)
    })
}
