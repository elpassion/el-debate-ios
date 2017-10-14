@testable import ELDebateFramework
import PromiseKit

class APIProviderStub: APIProviding {

    var debateAuthToken: String?
    var votingAuthToken: String?
    var votingAnswer: Answer?
    var commentContext: VoteContext?
    var commentText: String?

    var commentResult: Promise<Bool> = Promise(value: true)
    var voteResult: Promise<Answer> = Promise(value: Answer.testDefault)

    var commentReturnValue: Promise<Bool>?

    func fetchDebate(authToken: String) -> Promise<Debate> {
        debateAuthToken = authToken

        return Promise(value: Debate.testDefault)
    }

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        votingAuthToken = authToken
        votingAnswer = answer

        return voteResult
    }

    func comment(_ text: String, with voteContext: VoteContext) -> Promise<Bool> {
        commentContext = voteContext
        commentText = text

        return commentResult
    }
}
