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

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func go(to route: Route) {
        navigator.pushViewController(PinEntryViewController(), animated: true)
    }

}
