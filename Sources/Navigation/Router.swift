//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

protocol Routing {

    var navigator: UINavigationController { get }

    func go(to route: Route)

}

class Router: Routing {

    let navigator: UINavigationController
    private let controllerFactory: ControllerCreating

    init(navigator: UINavigationController, controllerFactory: ControllerCreating) {
        self.navigator = navigator
        self.controllerFactory = controllerFactory
    }

    func go(to route: Route) {
        let pinEntryController = controllerFactory.makeController(of: .pinEntry)
        navigator.pushViewController(pinEntryController.controller, animated: true)
    }

}
