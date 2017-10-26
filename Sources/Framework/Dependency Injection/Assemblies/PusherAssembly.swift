import PusherSwift
import Swinject
import SwinjectAutoregistration

class PusherAssembly: Assembly {

    func assemble(container: Container) {

        container.register(PusherConfigurationProviding.self) { _ in
            return PusherConfigurationProvider(pusherKeysDictionary: Bundle.main.infoDictionary)
        }

        container.register(Pusher.self) { resolver in
            let configuration = resolver ~> PusherConfigurationProviding.self
            let options = PusherClientOptions(host: .cluster(configuration.clusterKey))
            return Pusher(key: configuration.appKey, options: options)
        }
    }

}
