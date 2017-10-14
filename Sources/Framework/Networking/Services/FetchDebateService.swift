import Alamofire
import Foundation
import PromiseKit

protocol FetchDebateServiceProtocol {
    func fetchDebate(authToken: String) -> Promise<Debate>
}

class FetchDebateService: FetchDebateServiceProtocol {

    init(requestExecutor: RequestExecuting,
         debateDeserializer: Deserializer<Debate>,
         URLProvider: URLProviding) {
        self.requestExecutor = requestExecutor
        self.debateDeserializer = debateDeserializer
        self.URLProvider = URLProvider
    }

    func fetchDebate(authToken: String) -> Promise<Debate> {
        let jsonResponse = requestExecutor.get(
            url: "\(URLProvider.url)/api/debate",
            headers: ["Authorization": authToken]
        )

        return request(with: jsonResponse.json, deserializedBy: self.debateDeserializer)
    }

    // MARK: - Private

    private let requestExecutor: RequestExecuting
    private let debateDeserializer: Deserializer<Debate>
    private let URLProvider: URLProviding

}
