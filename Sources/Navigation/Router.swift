//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

protocol Routing {

    var navigator: UINavigationController { get }

    func go(to route: Route)
    func reset(to route: Route)
    func goBack()

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
        let provider = makeProvider(for: route)
        navigator.pushViewController(provider.controller, animated: true)
    }

    func reset(to route: Route) {
        let provider = makeProvider(for: route)
        navigator.setViewControllers([provider.controller], animated: true)
    }

    func goBack() {
        navigator.popViewController(animated: true)
    }

    // MARK: - Routing methods

    private func makeProvider(for route: Route) -> ControllerProviding {
        switch route {
        case .pinEntry:
            return makePinEntryProvider()
        case let .answer(voteContext):
            return makeAnswerProvider(for: voteContext)
        case let .comment(authToken):
            return makeCommentProvider(for: authToken)
        }
    }

    private func makePinEntryProvider() -> ControllerProviding {
        let provider = controllerFactory.makeController(of: .pinEntry)
        controllerConfigurator.configure(controller: provider, with: self)

        return provider
    }

    private func makeAnswerProvider(for voteContext: VoteContext) -> ControllerProviding {
        let provider = controllerFactory.makeController(of: .answer(voteContext: voteContext))
        controllerConfigurator.configure(controller: provider, with: self)

        return provider
    }

    private func makeCommentProvider(for authToken: String) -> ControllerProviding {
        let provider = controllerFactory.makeController(of: .comment(authToken: authToken))
        controllerConfigurator.configure(controller: provider, with: self)

        return provider
    }

}
