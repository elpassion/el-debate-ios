import Swinject
import SwinjectAutoregistration

class FetchDebateServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(Deserializer<Debate>.self, name: "Debate") { _ in
            return DebateDeserializer.build()
        }

        container.register(FetchDebateServiceProtocol.self) { resolver in
            return FetchDebateService(requestExecutor: resolver ~> RequestExecuting.self,
                                      debateDeserializer: resolver ~> (Deserializer<Debate>.self,
                                                                       name: "Debate"),
                                      URLProvider: resolver ~> URLProviding.self)

        }
    }

}
