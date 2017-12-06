@testable import ELDebateFramework

class VoteContextProviderStub: VoteContextProvider {
    private var context: VoteContext?
    
    func provide(voteContext: VoteContext) {
        context = voteContext
    }
    
    func voteContext() -> VoteContext? {
        return context
    }
}
