protocol PusherConfigurationProviding {
    var appKey: String { get }
    var clusterKey: String { get }
}

class PusherConfigurationProvider: PusherConfigurationProviding {

    private let infoDictionary: [String: Any]?

    init(infoDictionary: [String: Any]?) {
        self.infoDictionary = infoDictionary
    }

    // MARK: - PusherConfigurationProviding

    var appKey: String {
        guard let pusherDict = infoDictionary?["Pusher"] as? [String: Any] else {
            fatalError("Couldn't unwrap infoDictionary")
        }

        guard let appKey = pusherDict["APP_KEY"] as? String else {
            fatalError("Some error")
        }

        if appKey.characters.isEmpty { fatalError("Please fill APP_KEY in info.plist") }

        return appKey
    }

    var clusterKey: String {
        guard let pusherDict = infoDictionary?["Pusher"] as? [String: Any] else {
            fatalError("Couldn't unwrap infoDictionary")
        }

        guard let clusterKey = pusherDict["CLUSTER_KEY"] as? String else {
           fatalError("Couldn't unwrap clusterKey")
        }

        if clusterKey.characters.isEmpty { fatalError("Please fill CLUSTER_KEY in info.plist") }

        return clusterKey
    }

}
