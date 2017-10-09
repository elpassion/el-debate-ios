import UIKit

protocol ControllerConfiguring: AutoMockable {

    func configure(controller: ControllerProviding, with router: Routing)

}

class ControllerConfigurator: ControllerConfiguring {

    func configure(controller: ControllerProviding, with router: Routing) {
        if let controller = controller as? PinEntryControllerProviding {
            controller.onVoteContextLoaded = { voteContext in router.go(to: .answer(voteContext: voteContext)) }
        }

        if let controller = controller as? CommentControllerProviding {
            router.go(to: .comment)
        }

    }

}
