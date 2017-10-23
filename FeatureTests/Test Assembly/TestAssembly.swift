@testable import ELDebateFramework
import Swinject
import SwinjectAutoregistration

class TestAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(FetchCommentsServiceProtocol.self, initializer: FeatureTestsFetchCommentsService.init)

        container.autoregister(FetchDebateServiceProtocol.self, initializer: FeatureTestsFetchDebateService.init)

        container.autoregister(LoginServiceProtocol.self, initializer: FeatureTestsLoginService.init)

        container.autoregister(VoteServiceProtocol.self, initializer: FeatureTestsVoteService.init)
    }

}
