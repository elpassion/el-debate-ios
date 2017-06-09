//
//  Created by Jakub Turek on 06.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

protocol CommentControllerPresenting: AutoMockable {

    func present(in controller: UIViewController, with context: VoteContext)

}

class CommentControllerPresenter: CommentControllerPresenting {

    private let controllerFactory: ControllerCreating

    init(controllerFactory: ControllerCreating) {
        self.controllerFactory = controllerFactory
    }

    func present(in controller: UIViewController, with context: VoteContext) {
        let commentController = controllerFactory.makeController(of: .comment(voteContext: context)).controller

        commentController.willMove(toParentViewController: controller)
        controller.addChildViewController(commentController)
        commentController.didMove(toParentViewController: controller)
        controller.view.addSubview(commentController.view)
        commentController.view.edgeAnchors == controller.view.edgeAnchors
    }

}
