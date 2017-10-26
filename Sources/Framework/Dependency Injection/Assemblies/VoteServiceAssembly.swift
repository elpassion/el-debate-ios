import Swinject
import SwinjectAutoregistration

class VoteServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(VoteServiceProtocol.self) { resolver in
            return VoteService(requestExecutor: resolver ~> RequestExecuting.self,
                               URLProvider: resolver ~> URLProviding.self)
        }
    }

}
