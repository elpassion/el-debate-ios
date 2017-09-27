import Swinject
import SwinjectAutoregistration

class APIAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(RequestExecuting.self, initializer: RequestExecutor.init)

        container.register(Deserializer<String>.self, name: "AuthToken") { _ in
            return Deserializer(AuthTokenDeserializer())
        }

        container.register(Deserializer<Debate>.self, name: "Debate") { _ in
            return DebateDeserializer.build()
        }

        container.register(APIProviding.self) { resolver in
            return ApiClient(
                requestExecutor: resolver ~> RequestExecuting.self,
                authTokenDeserializer: resolver ~> (Deserializer<String>.self, name: "AuthToken"),
                debateDeserializer: resolver ~> (Deserializer<Debate>.self, name: "Debate")
            )
        }
    }

}
