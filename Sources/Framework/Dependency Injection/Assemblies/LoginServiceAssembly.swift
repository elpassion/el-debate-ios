import PusherSwift
import Swinject
import SwinjectAutoregistration

class LoginServiceAssembly: Assembly {

    func assemble(container: Container) {

        container.register(Deserializer<String>.self, name: "AuthToken") { _ in
            return Deserializer(AuthTokenDeserializer())
        }

        container.register(LoginServiceProtocol.self) { resolver in
            return LoginService(requestExecutor: resolver ~> RequestExecuting.self,
                                authTokenDeserializer: resolver ~> (Deserializer<String>.self,
                                                                    name: "AuthToken"),
                                URLProvider: resolver ~> URLProviding.self)
        }
    }

}
