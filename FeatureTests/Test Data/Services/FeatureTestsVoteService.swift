@testable import ELDebateFramework
import PromiseKit

class FeatureTestsVoteService: VoteServiceProtocol {

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        return Promise(value: answer)
    }

}
