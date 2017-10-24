import Foundation
import PromiseKit
import PusherSwift

protocol CommentsWebSocketProtocol {

    func startWebSocket()

}

class CommentsWebSocket: CommentsWebSocketProtocol {

    init(commentsDeserializer: Deserializer<Comments>,
         URLProvider: URLProviding,
         pusher: Pusher) {
        self.commentsDeserializer = commentsDeserializer
        self.URLProvider = URLProvider
        self.pusher = pusher
    }

    func startWebSocket() {
        pusher.connect()

        let myChannel = pusher.subscribe("dashboard_channel_13160") //+ numer debaty

        _ = myChannel.bind(eventName: "comment_added") { (data: Any?) -> Void in
            if let data = data as? [String: AnyObject] {
                print (data)
            }
        }
    }

    // MARK: - Private

    private let commentsDeserializer: Deserializer<Comments>
    private let URLProvider: URLProviding
    private let pusher: Pusher

}
