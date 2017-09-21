@testable import ELDebateFramework
import Swinject
import SwinjectAutoregistration

class TestAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(APIProviding.self, initializer: FeatureTestsAPIClient.init)
    }

}
