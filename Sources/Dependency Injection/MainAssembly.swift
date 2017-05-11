//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class MainAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MainWindowCreating.self) { _ in MainWindowFactory(screenBounds: UIScreen.main.bounds) }
        container.register(ControllerCreating.self) { resolver in ControllerFactory(resolver: resolver) }
        container.register(Routing.self) { resolver in
            Router(navigator: UINavigationController(), controllerFactory: resolver ~> ControllerCreating.self)
        }

    }

}
