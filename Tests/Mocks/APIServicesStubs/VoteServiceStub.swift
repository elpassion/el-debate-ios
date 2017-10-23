@testable import ELDebateFramework
import PromiseKit

class VoteServiceStub: VoteServiceProtocol {

    var votingAuthToken: String?
    var votingAnswer: Answer?
    var voteResult: Promise<Answer> = Promise(value: Answer.testDefault)

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        votingAuthToken = authToken
        votingAnswer = answer

        return voteResult
    }

}
