@testable import ELDebateFramework
import Swinject

class DebateRunnerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Routing.self) { (_, navigationController: UINavigationController) in
            return RouterMock(navigator: navigationController)
        }
    }

}
