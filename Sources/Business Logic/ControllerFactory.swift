//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

public enum ControllerType {

    case pinEntry
    case answer(voteContext: VoteContext)

}

public protocol ControllerCreating {

    func makeController(of type: ControllerType) -> ControllerProviding

}

public class ControllerFactory: ControllerCreating {

    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func makeController(of type: ControllerType) -> ControllerProviding {
        switch type {
        case .pinEntry:
            return resolver ~> PinEntryViewController.self
        case let .answer(debate):
            return resolver ~> (AnswerViewController.self, argument: debate)
        }
    }

}
