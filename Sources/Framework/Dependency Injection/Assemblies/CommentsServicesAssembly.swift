import PusherSwift
import Swinject
import SwinjectAutoregistration

class CommentsServicesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(LoginCredentialsStoring.self, name: "LoginCredentials") { _ in
            return LoginCredentialsStore(userDefaults: UserDefaults.standard)
        }

        container.register(FetchCommentsServiceProtocol.self) { resolver in
            return FetchCommentsService(
                    requestExecutor: resolver ~> RequestExecuting.self,
                    commentsDeserializer: resolver ~> (Deserializer<Comments>.self, name: "Comments"),
                    URLProvider: resolver ~> URLProviding.self
            )
        }

        container.register(Deserializer<Comments>.self, name: "Comments") { _ in
            return Deserializer(CommentsDeserializer(jsonDecoder: JSONDecoder()))
        }

        container.register(Deserializer<Comment>.self, name: "Comment") { _ in
            return Deserializer(CommentDeserializer(jsonDecoder: JSONDecoder()))
        }

        container.register(CommentsWebSocketProtocol.self) { resolver in
            return CommentsWebSocket(
                    commentDeserializer: resolver ~> (Deserializer<Comment>.self, name: "Comment"),
                    pusher: resolver ~> Pusher.self,
                    lastCredentialsStore: resolver ~> (LoginCredentialsStoring.self, name: "LoginCredentials")
            )
        }

        container.register(NewCommentServiceProtocol.self) { resolver in
            return NewCommentService(
                    requestExecutor: resolver ~> RequestExecuting.self,
                    URLProvider: resolver ~> URLProviding.self,
                    commentDeserializer: resolver ~> (Deserializer<Comment>.self, name: "Comment"),
                    voteContextProvider: resolver ~> VoteContextProvider.self
            )
        }

        container.register(VoteContextProvider.self) { resolver in
            return VoteContextRepository()
        }.inObjectScope(.container)

        container.register(UserInfoRepository.self) { resolver in
            return PersistentUserInfoRepository(userDefaults: UserDefaults.standard)
        }
    }

}
