@testable import ELDebateFramework
import PromiseKit

class FetchCommentsServiceStub: FetchCommentsServiceProtocol {

    var debateAuthToken: String?

    func fetchComments(authToken: String) -> Promise<Comments> {
        debateAuthToken = authToken
        return Promise(Comments.testDefault)
    }

}
