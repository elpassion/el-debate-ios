//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import UIKit

class ControllerFactoryMock: ControllerCreating {

    let pinEntryProvider = PinEntryControllerMockProvider()
    let answerProvider = AnswerControllerMockProvider()

    var lastType: ControllerType?

    func makeController(of type: ControllerType) -> ControllerProviding {
        lastType = type

        switch type {
        case .pinEntry:
            return pinEntryProvider
        case .answer:
            return answerProvider
        }
    }

}

class ControllerMockProvider: ControllerProviding  {

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
