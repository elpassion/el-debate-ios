//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import UIKit

class RouterMock: Routing {

    var navigator = UINavigationController()
    var lastRoute: Route?

    func go(to route: Route) {
        lastRoute = route
    }

}