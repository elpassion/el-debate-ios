@testable import ELDebateFramework
import PromiseKit

class FetchDebateServiceStub: FetchDebateServiceProtocol {

    var debateAuthToken: String?

    func fetchDebate(authToken: String) -> Promise<Debate> {
        debateAuthToken = authToken

        return Promise(value: Debate.testDefault)
    }

}
