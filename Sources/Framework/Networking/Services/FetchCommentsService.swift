import Alamofire
import Foundation
import PromiseKit

protocol FetchCommentsServiceProtocol {
    func fetchComments(authToken: String) -> Promise<Comments>
}

class FetchCommentsService: FetchCommentsServiceProtocol {

    init(requestExecutor: RequestExecuting,
         commentsDeserializer: Deserializer<Comments>,
         URLProvider: URLProvider) {

        self.requestExecutor = requestExecutor
        self.commentsDeserializer = commentsDeserializer
        self.URLProvider = URLProvider
    }

    func fetchComments(authToken: String) -> Promise<Comments> {
        let jsonResponse = requestExecutor.get(
            url: "\(URLProvider.url)/api/comments",
            headers: ["Authorization": authToken]
        )

        return request(with: jsonResponse.json, deserializedBy: self.commentsDeserializer)
    }

    // MARK: - Private

    private let requestExecutor: RequestExecuting
    private let commentsDeserializer: Deserializer<Comments>
    private let URLProvider: URLProviding

}
