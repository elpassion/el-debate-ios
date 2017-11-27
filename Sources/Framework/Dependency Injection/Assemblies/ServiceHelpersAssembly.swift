import PusherSwift
import Swinject
import SwinjectAutoregistration

class ServiceHelpersAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(RequestExecuting.self, initializer: RequestExecutor.init)

        container.autoregister(URLProviding.self, initializer: URLProvider.init)
    }

}
