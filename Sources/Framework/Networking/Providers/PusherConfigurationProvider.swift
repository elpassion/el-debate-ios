import Foundation

protocol PusherConfigurationProviding {
    var appKey: String { get }
    var clusterKey: String { get }
}

class PusherConfigurationProvider: PusherConfigurationProviding {

    private let pusherKeysDictionary: [String: Any]?

    init(pusherKeysDictionary: [String: Any]?) {

        let resource = "PusherKeys"
        let fileExtension = "plist"

        guard let pusherPlistPath = Bundle.main.path(forResource: resource,
                                                     ofType: fileExtension) else {
            fatalError("Either infoDictPath is wrong or file doesn't exist")
        }

        guard let pusherKeysDictionaryFromPlist = NSDictionary(contentsOfFile: pusherPlistPath) as? [String: AnyObject] else {
            fatalError("URL: Couldn't unwrap custom Plist properly - maybe it's Array and not Dictionary?")
        }

        self.pusherKeysDictionary = pusherKeysDictionaryFromPlist
    }

    // MARK: - PusherConfigurationProviding

    var appKey: String {
        guard let pusherDict = pusherKeysDictionary?["Pusher"] as? [String: Any] else {
            fatalError("Couldn't unwrap infoDictionary")
        }

        guard let appKey = pusherDict["APP_KEY"] as? String else {
            fatalError("Couldn't get appKey from Dictionary")
        }

        if appKey.characters.isEmpty { fatalError("Please fill APP_KEY in PusherKeys.plist") }

        return appKey
    }

    var clusterKey: String {
        guard let pusherDict = pusherKeysDictionary?["Pusher"] as? [String: Any] else {
            fatalError("Couldn't unwrap infoDictionary")
        }

        guard let clusterKey = pusherDict["CLUSTER_KEY"] as? String else {
           fatalError("Couldn't get clusterKey from Dictionary")
        }

        if clusterKey.characters.isEmpty { fatalError("Please fill CLUSTER_KEY in PusherKeys.plist") }

        return clusterKey
    }

}
