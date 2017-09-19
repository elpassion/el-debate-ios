@testable import ELDebateFramework
import UIKit

class ControllerFactoryMock: ControllerCreating {

    let pinEntryProvider = PinEntryControllerMockProvider()
    let answerProvider = AnswerControllerMockProvider()
    let commentProvider = CommentControllerMockProvider()

    var lastType: ControllerType?
    var lastContext: VoteContext?

    func makeController(of type: ControllerType) -> ControllerProviding {
        lastType = type

        switch type {
        case .pinEntry:
            return pinEntryProvider
        case let .answer(voteContext: voteContext):
            lastContext = voteContext
            return answerProvider
        case let .comment(voteContext: voteContext):
            lastContext = voteContext
            return commentProvider
        }
    }

}

class ControllerMockProvider: ControllerProviding {

    let controller = UIViewController()

}

class PinEntryControllerMockProvider: PinEntryControllerProviding {

    let controller = UIViewController()

    var onVoteContextLoaded: ((VoteContext) -> Void)?

}

class AnswerControllerMockProvider: AnswerControllerProviding {

    let controller = UIViewController()

    var onChatButtonTapped: ((String) -> Void)?

}

class CommentControllerMockProvider: ControllerProviding {

    let controller: UIViewController = ChildControllerSpy()

}
