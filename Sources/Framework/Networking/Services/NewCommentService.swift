import Alamofire
import Foundation
import PromiseKit

protocol NewCommentServiceProtocol {
    func create(comment: String, name: String) -> Promise<Comment>
}

class NewCommentService: NewCommentServiceProtocol {

    init(requestExecutor: RequestExecuting,
         URLProvider: URLProviding,
         commentDeserializer: Deserializer<Comment>,
         voteContextProvider: VoteContextProvider) {
        self.requestExecutor = requestExecutor
        self.URLProvider = URLProvider
        self.commentDeserializer = commentDeserializer
        self.voteContextProvider = voteContextProvider
    }

    func create(comment: String, name: String) -> Promise<Comment> {
        guard let token = voteContextProvider.voteContext()?.authToken else {
            fatalError("Auth token needs to be created in order to send requests")
        }

        let response = requestExecutor.post(
                url: "\(URLProvider.url)/api/comments",
                body: ["text": comment, "first_name": name],
                headers: ["Authorization": token]
        )

        return request(with: response.json, deserializedBy: self.commentDeserializer)
    }

    // MARK: - Private

    private let requestExecutor: RequestExecuting
    private let URLProvider: URLProviding
    private let commentDeserializer: Deserializer<Comment>
    private let voteContextProvider: VoteContextProvider

}
