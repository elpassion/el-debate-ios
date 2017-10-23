public enum Route {

    case pinEntry
    case answer(voteContext: VoteContext)
    case comment(voteContext: VoteContext)

}
