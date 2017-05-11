//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class PinEntryAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(PinEntryViewController.self, initializer: PinEntryViewController.init)
        container.autoregister(RequestExecuting.self, initializer: RequestExecutor.init)

        container.register(Deserializer<String>.self, name: "AuthTokenDeserializer") { _ in
            return Deserializer(AuthTokenDeserializer())
        }

        container.register(ApiClient.self) { resolver in
            let requestExecutor = resolver ~> RequestExecuting.self
            let authTokenDeserializer = resolver ~> (Deserializer<String>.self, name: "AuthTokenDeserializer")

            return ApiClient(requestExecutor: requestExecutor, authTokenDeserializer: authTokenDeserializer)
        }
    }

}
