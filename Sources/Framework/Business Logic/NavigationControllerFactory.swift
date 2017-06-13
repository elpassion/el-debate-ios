//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol NavigationControllerCreating {

    func makeNavigationController() -> UINavigationController

}

class NavigationControllerFactory: NavigationControllerCreating {

    func makeNavigationController() -> UINavigationController {
        let controller = UINavigationController()
        controller.applyDebateStyle()

        return controller
    }

}
