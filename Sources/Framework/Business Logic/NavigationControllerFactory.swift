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
