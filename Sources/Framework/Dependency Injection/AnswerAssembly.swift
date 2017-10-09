import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CommentController.self, argument: VoteContext.self, initializer: CommentController.init)
        container.autoregister(AnswerViewController.self, argument: VoteContext.self,
                               initializer: AnswerViewController.init)
    }

}
