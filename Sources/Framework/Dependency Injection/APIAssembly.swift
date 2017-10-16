import Swinject
import SwinjectAutoregistration

class APIAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(RequestExecuting.self, initializer: RequestExecutor.init)

        container.autoregister(URLProviding.self, initializer: URLProvider.init)

        container.register(Deserializer<Comments>.self, name: "Comments") { _ in
            return Deserializer(CommentsDeserializer(jsonDecoder: JSONDecoder()))
        }

        container.register(Deserializer<Debate>.self, name: "Debate") { _ in
            return DebateDeserializer.build()
        }

        container.register(Deserializer<String>.self, name: "AuthToken") { _ in
            return Deserializer(AuthTokenDeserializer())
        }

        container.register(VoteServiceProtocol.self) { resolver in
            return VoteService(requestExecutor: resolver ~> RequestExecuting.self,
                               URLProvider: resolver ~> URLProviding.self)
        }

        container.register(FetchCommentsServiceProtocol.self) { resolver in
            return FetchCommentsService(requestExecutor: resolver ~> RequestExecuting.self,
                                        commentsDeserializer: resolver ~> (Deserializer<Comments>.self,
                                                                           name: "Comments"),
                                        URLProvider: resolver ~> URLProviding.self)
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
