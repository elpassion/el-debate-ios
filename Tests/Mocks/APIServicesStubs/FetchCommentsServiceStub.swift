@testable import ELDebateFramework
import PromiseKit

class FetchCommentsServiceStub: FetchCommentsServiceProtocol {
    func fetchComments(authToken: String) -> Promise<Comments> {
        let jsonResponse = {""}

        return request(with: jsonResponse.json, deserializedBy: self.commentsDeserializer)
    }

}
