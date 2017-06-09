//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class PinEntryAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(RequestExecuting.self, initializer: RequestExecutor.init)
        container.autoregister(AlertShowing.self, initializer: AlertPresenter.init)

        container.register(Deserializer<String>.self, name: "AuthTokenDeserializer") { _ in
            return Deserializer(AuthTokenDeserializer())
        }

        container.register(APIProviding.self) { resolver in
            let requestExecutor = resolver ~> RequestExecuting.self
            let authTokenDeserializer = resolver ~> (Deserializer<String>.self, name: "AuthTokenDeserializer")
            let debateDeserializer = resolver ~> (Deserializer<Debate>.self, name: "DebateDeserializer")

            return ApiClient(
                requestExecutor: requestExecutor,
                authTokenDeserializer: authTokenDeserializer,
                debateDeserializer: debateDeserializer
            )
        }

        container.register(Deserializer<Debate>.self, name: "DebateDeserializer") { _ in
            return DebateDeserializer.build()
        }

        container.register(LoginCredentialsStoring.self) { _ in
            return LoginCredentialsStore(userDefaults: UserDefaults.standard)
        }

        container.autoregister(LoginActionHandling.self, initializer: LoginActionHandler.init)
        container.autoregister(PinEntryViewController.self, initializer: PinEntryViewController.init)
    }

}
