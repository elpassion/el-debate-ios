@testable import ELDebateFramework

extension VoteContext {

    static var testDefault: VoteContext {
        return VoteContext(
            debate: Debate.testDefault,
            authToken: "whatever",
            username: "some user"
        )
    }
}
