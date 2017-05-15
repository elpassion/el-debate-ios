//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import KeychainAccess
import Swinject
import SwinjectAutoregistration

class MainAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(NavigationControllerCreating.self, initializer: NavigationControllerFactory.init)
        container.autoregister(ControllerConfiguring.self, initializer: ControllerConfigurator.init)
        container.register(MainWindowCreating.self) { _ in MainWindowFactory(screenBounds: UIScreen.main.bounds) }
        container.register(ControllerCreating.self) { resolver in ControllerFactory(resolver: resolver) }

        container.register(Routing.self) { resolver in
            let navigatorFactory = resolver ~> NavigationControllerCreating.self
            return Router(navigator: navigatorFactory.makeNavigationController(),
                          controllerFactory: resolver ~> ControllerCreating.self,
                          controllerConfigurator: resolver ~> ControllerConfiguring.self)
        }

        container.register(AuthTokenStoring.self) { _ in
            let keychain = Keychain(service: "com.herokuapp.el-debate.auth_token")
            return AuthTokenStorage(keychain: keychain)
        }
    }
}
