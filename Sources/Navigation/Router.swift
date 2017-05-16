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
    private let controllerConfigurator: ControllerConfiguring

    init(navigator: UINavigationController, controllerFactory: ControllerCreating,
         controllerConfigurator: ControllerConfiguring) {
        self.navigator = navigator
        self.controllerFactory = controllerFactory
        self.controllerConfigurator = controllerConfigurator
    }

    func go(to route: Route) {
        switch route {
        case .pinEntry:
            goToPinEntry()
        case let .answer(debate):
            goToAnswer(for: debate)
        }
    }

    // MARK: - Routing methods

    private func goToPinEntry() {
        guard let provider = controllerFactory.makeController(of: .pinEntry) as? PinEntryControllerProviding else {
            fatalError("Expected built provider to be of class PinEntryControllerProviding")
        }

        controllerConfigurator.configure(controller: provider, with: self)
        navigator.pushViewController(provider.controller, animated: true)
    }

    private func goToAnswer(for debate: Debate) {
        let provider = controllerFactory.makeController(of: .answer(debate: debate))
        controllerConfigurator.configure(controller: provider, with: self)

        navigator.pushViewController(provider.controller, animated: true)
    }

}
