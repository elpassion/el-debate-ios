import PromiseKit
import UIKit

public protocol Routing {

    var navigator: UINavigationController { get }

    func go(to route: Route)
    func reset(to route: Route)

}

public class Router: Routing {

    public let navigator: UINavigationController
    private let controllerFactory: ControllerCreating
    private let controllerConfigurator: ControllerConfiguring

    init(navigator: UINavigationController,
         controllerFactory: ControllerCreating,
         controllerConfigurator: ControllerConfiguring) {
        self.navigator = navigator
        self.controllerFactory = controllerFactory
        self.controllerConfigurator = controllerConfigurator
    }

    public func go(to route: Route) {
        let provider = makeProvider(for: route)
        navigator.pushViewController(provider.controller, animated: true)
    }

    public func reset(to route: Route) {
        let provider = makeProvider(for: route)
        navigator.setViewControllers([provider.controller], animated: true)
    }

    // MARK: - Routing methods

    private func makeProvider(for route: Route) -> ControllerProviding {
        switch route {
        case .pinEntry:
            return makePinEntryProvider()
        case let .answer(voteContext):
            return makeAnswerProvider(for: voteContext)
        case let .comment(voteContext):
            return makeCommentEntryProvider(for: voteContext)
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

    private func makeCommentEntryProvider(for voteContext: VoteContext) -> ControllerProviding {
        let provider = controllerFactory.makeController(of: .comment(voteContext: voteContext))
        controllerConfigurator.configure(controller: provider, with: self)

        return provider
    }

}
