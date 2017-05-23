//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

enum ControllerType {

    case pinEntry
    case answer(voteContext: VoteContext)
    case comment(authToken: String)

}

protocol ControllerCreating {

    func makeController(of type: ControllerType) -> ControllerProviding

}

class ControllerFactory: ControllerCreating {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func makeController(of type: ControllerType) -> ControllerProviding {
        switch type {
        case .pinEntry:
            return resolver ~> PinEntryViewController.self
        case let .answer(debate):
            return resolver ~> (AnswerViewController.self, argument: debate)
        case let .comment(authToken):
            return resolver ~> (CommentViewController.self, argument: authToken)
        }
    }

}
