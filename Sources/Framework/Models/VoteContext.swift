import Foundation

public struct VoteContext {

    let debate: Debate
    let authToken: String
    let username: String?

}

// swiftlint:disable no_extension_access_modifier

public extension VoteContext {

    func answer(for answerType: AnswerType) -> Answer {
        switch answerType {
        case .positive:
            return debate.positiveAnswer
        case .neutral:
            return debate.neutralAnswer
        case .negative:
            return debate.negativeAnswer
        }
    }

}
