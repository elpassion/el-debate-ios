import Alamofire
import Foundation
import PusherSwift

protocol CommentsWebSocketDelegate: class {
    func commentReceived(comment: Comment)
}

protocol CommentsWebSocketProtocol {

    func startWebSocket(delegate: CommentsWebSocketDelegate)

}

class CommentsWebSocket: CommentsWebSocketProtocol {

    init(commentDeserializer: Deserializer<Comment>,
         pusher: Pusher,
         lastCredentialsStore: LoginCredentialsStoring) {
        self.commentDeserializer = commentDeserializer
        self.pusher = pusher
        self.lastCredentialsStore = lastCredentialsStore
    }

    func startWebSocket(delegate: CommentsWebSocketDelegate) {

        guard let channelPin = lastCredentialsStore.lastCredentials?.pin else {
            fatalError("Error retrieving Pin from Stored Credentuals")
        }
        let channelName = "dashboard_channel_"

        pusher.connect()

        let debateChannel = pusher.subscribe("\(channelName)\(channelPin)")

        _ = debateChannel.bind(eventName: "comment_added") { (data: Any?) -> Void in

            guard let data = data as? [String: AnyObject] else {
                return
            }

            guard let commentBody = try? self.commentDeserializer.deserialize(json: data) else {
                return
            }

            delegate.commentReceived(comment: commentBody)

        }
    }

    // MARK: - Private

    private let commentDeserializer: Deserializer<Comment>
    private let lastCredentialsStore: LoginCredentialsStoring
    private let pusher: Pusher
}
