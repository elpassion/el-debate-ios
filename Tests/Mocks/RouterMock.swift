//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import UIKit

class RouterMock: Routing {

    var navigator: UINavigationController
    var lastRoute: Route?
    var lastResetToRoute: Route?
    var goneBack = false

    convenience init() {
        self.init(navigator: UINavigationController())
    }

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func go(to route: Route) {
        lastRoute = route
    }

    func reset(to route: Route) {
        lastResetToRoute = route
    }
}
