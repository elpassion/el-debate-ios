import Foundation

protocol PusherConfigurationProviding {
    var appKey: String { get }
    var clusterKey: String { get }
}

class PusherConfigurationProvider: PusherConfigurationProviding {

    private let infoDictionary: [String: Any]?

    init(infoDictionary: [String: Any]?) {
        self.infoDictionary = infoDictionary
        fromPath()
    }

    private func fromPath() {

        let resource = "PusherKeys"
        let fileExtension = "plist"

        guard let infoDictPath = Bundle.main.path(forResource: resource,
                                                  ofType: fileExtension
                                                  ) else {
            fatalError("Either infoDictPath is wrong or file doesn't exist")
        }

        guard let PusherKeys = NSDictionary(contentsOfFile: infoDictPath) as? [String: AnyObject] else {
            fatalError("URL: Couldn't unwrap custom Plist properly - maybe it's Array and not Dictionary?")
        }

    }

    // MARK: - PusherConfigurationProviding

    var appKey: String {
        guard let pusherDict = infoDictionary?["Pusher"] as? [String: Any] else {
            fatalError("Couldn't unwrap infoDictionary")
        }

        guard let appKey = pusherDict["APP_KEY"] as? String else {
            fatalError("Couldn't get appKey from Dictionary")
        }

        if appKey.characters.isEmpty { fatalError("Please fill APP_KEY in PusherKeys.plist") }

        return appKey
    }

    var clusterKey: String {
        guard let pusherDict = infoDictionary?["Pusher"] as? [String: Any] else {
            fatalError("Couldn't unwrap infoDictionary")
        }

        guard let clusterKey = pusherDict["CLUSTER_KEY"] as? String else {
           fatalError("Couldn't get clusterKey from Dictionary")
        }

        if clusterKey.characters.isEmpty { fatalError("Please fill CLUSTER_KEY in PusherKeys.plist") }

        return clusterKey
    }

}
