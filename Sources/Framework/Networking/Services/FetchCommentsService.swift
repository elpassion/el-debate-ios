import Alamofire
import Foundation
import PromiseKit

protocol FetchCommentsServiceProtocol {
    func fetchComments(authToken: String) -> Promise<Comments>
}

class FetchCommentsService: FetchCommentsServiceProtocol {

    private let requestExecutor: RequestExecuting
    private let commentsDeserializer: Deserializer<Comments>
    private let URLProvider: URLProviding

    init(requestExecutor: RequestExecuting,
         commentsDeseliarizer: Deserializer<Comments>,
         URLProvider: URLProvider) {

        self.requestExecutor = requestExecutor
        self.commentsDeserializer = commentsDeseliarizer
        self.URLProvider = URLProvider
    }

    func fetchComments(authToken: String) -> Promise<Comments> {
        let jsonResponse = requestExecutor.get(
            url: "\(URLProvider.url)/api/comments",
            headers: ["Authorization": authToken]
        )

        return request(with: jsonResponse.json, deserializedBy: self.commentsDeserializer)
    }

    private func request<T>(with executor: @escaping (@escaping (ApiResponse) -> Void) -> Void,
                            deserializedBy deserializer: Deserializer<T>) -> Promise<T> {
        return Promise(requestExecutor: executor) { response in
            try deserializer.deserialize(json: response.json)
        }
    }
}
