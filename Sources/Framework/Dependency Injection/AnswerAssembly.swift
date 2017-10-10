import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CommentViewController.self, argument: VoteContext.self,
                               initializer: CommentViewController.init)
        container.autoregister(AnswerViewController.self, argument: VoteContext.self,
                               initializer: AnswerViewController.init)
    }

}
