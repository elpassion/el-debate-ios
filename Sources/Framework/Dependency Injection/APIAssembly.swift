import PusherSwift
import Swinject
import SwinjectAutoregistration

class APIAssembly: Assembly {

    func assemble(container: Container) {

        container.register(Deserializer<Debate>.self, name: "Debate") { _ in
            return DebateDeserializer.build()
        }

        container.register(Deserializer<String>.self, name: "AuthToken") { _ in
            return Deserializer(AuthTokenDeserializer())
        }

        container.register(FetchDebateServiceProtocol.self) { resolver in
            return FetchDebateService(requestExecutor: resolver ~> RequestExecuting.self,
                                      debateDeserializer: resolver ~> (Deserializer<Debate>.self,
                                                                       name: "Debate"),
                                      URLProvider: resolver ~> URLProviding.self)

        }

        container.register(LoginServiceProtocol.self) { resolver in
            return LoginService(requestExecutor: resolver ~> RequestExecuting.self,
                                authTokenDeserializer: resolver ~> (Deserializer<String>.self,
                                                                    name: "AuthToken"),
                                URLProvider: resolver ~> URLProviding.self)
        }
    }

}
