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
            return ""
        }

        guard let appKey = pusherDict["APP_KEY"] as? String else {
            return ""
        }

        return appKey
    }
    var clusterKey: String {
        guard let pusherDict = infoDictionary?["Pusher"] as? [String: Any] else {
            return ""
        }

        guard let clusterKey = pusherDict["CLUSTER_KEY"] as? String else {
            return ""
        }

        return clusterKey
    }

}
