import Swinject
import SwinjectAutoregistration

class CommentAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(CommentViewController.self, initializer: CommentViewController.init)
    }
}
