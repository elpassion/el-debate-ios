import Alamofire
import Foundation
import PusherSwift

protocol CommentsWebSocketDelegate {
    func commentReceived(comment: Comment)
}

protocol CommentsWebSocketProtocol {

    func startWebSocket(delegate: CommentsWebSocketDelegate)

}

class CommentsWebSocket: CommentsWebSocketProtocol {

    init(commentDeserializer: Deserializer<Comment>,
         pusher: Pusher) {
        self.commentDeserializer = commentDeserializer
        self.pusher = pusher
    }

    func startWebSocket(delegate: CommentsWebSocketDelegate) {
        pusher.connect()
        let myChannel = pusher.subscribe("dashboard_channel_13160")

        _ = myChannel.bind(eventName: "comment_added") { (data: Any?) -> Void in

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
    private let pusher: Pusher
}
