//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol ControllerConfiguring: AutoMockable {

    func configure(controller: ControllerProviding, with router: Routing)

}

class ControllerConfigurator: ControllerConfiguring {

    func configure(controller: ControllerProviding, with router: Routing) {
        if let controller = controller as? PinEntryControllerProviding {
            controller.onVoteContextLoaded = { voteContext in router.go(to: .answer(voteContext: voteContext)) }
        }

        if let controller = controller as? AnswerControllerProviding {
            controller.onChatButtonTapped = { authToken in router.go(to: .comment(authToken: authToken)) }
        }

        if let controller = controller as? CommentControllerProviding {
            controller.onCommentSubmitted = {
                router.goBack()
            }
        }
    }

}
