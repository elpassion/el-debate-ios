import Alamofire
import Foundation
import PromiseKit

protocol VoteServiceProtocol {
    func vote(authToken: String, answer: Answer) -> Promise<Answer>
}

class VoteService: VoteServiceProtocol {

    init(requestExecutor: RequestExecuting,
         URLProvider: URLProviding) {
        self.requestExecutor = requestExecutor
        self.URLProvider = URLProvider
    }

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        let response = requestExecutor.post(
            url: "\(URLProvider.url)/api/vote",
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

    // MARK: - Private

    private let requestExecutor: RequestExecuting
    private let URLProvider: URLProviding

}
