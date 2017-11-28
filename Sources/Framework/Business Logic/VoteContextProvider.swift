protocol VoteContextProvider {
    func provide(voteContext: VoteContext)
    func voteContext() -> VoteContext?
}

class VoteContextRepository: VoteContextProvider {
    var context: VoteContext?

    func provide(voteContext: VoteContext) {
        context = voteContext
    }

    func voteContext() -> VoteContext? {
        return context
    }
}
