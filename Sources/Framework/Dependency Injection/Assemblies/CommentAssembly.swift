import Swinject
import SwinjectAutoregistration

class CommentAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
                CommentViewController.self,
                argument: VoteContext.self,
                initializer: CommentViewController.init
        )
        container.autoregister(NewCommentControllerProtocol.self, initializer: NewCommentController.init)
    }
}
