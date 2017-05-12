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
        switch route {
        case .pinEntry:
            goToPinEntry()
        case .answer:
            goToAnswer()
        }
    }

    private func goToPinEntry() {
        guard let pinEntryController = controllerFactory.makeController(of: .pinEntry) as? PinEntryControllerProviding else { fatalError() }
        pinEntryController.onSuccessfulLogin = { _ in
            self.go(to: .answer)
        }

        navigator.pushViewController(pinEntryController.controller, animated: true)
    }

    private func goToAnswer() {
        let answerViewController = controllerFactory.makeController(of: .answer)

        navigator.pushViewController(answerViewController.controller, animated: true)
    }

}
