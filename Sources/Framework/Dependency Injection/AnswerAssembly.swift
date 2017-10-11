import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(AnswerViewController.self, argument: VoteContext.self,
                               initializer: AnswerViewController.init)
    }

}
