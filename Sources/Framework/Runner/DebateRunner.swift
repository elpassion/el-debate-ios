//
//  Created by Jakub Turek on 13.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import UIKit

public protocol DebateRunning {

    func start(in navigationController: UINavigationController, applyingDebateStyle: Bool)

}

public class DebateRunner: DebateRunning {

    private let resolver: Resolver
    private var router: Routing?

    public convenience init() {
        let assembler = Assembler.defaultAssembler

        self.init(resolver: assembler.resolver)
    }

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    public func start(in navigationController: UINavigationController, applyingDebateStyle: Bool) {
        router = Router(navigator: navigationController,
                        controllerFactory: resolver ~> ControllerCreating.self,
                        controllerConfigurator: resolver ~> ControllerConfiguring.self)

        if applyingDebateStyle {
            navigationController.applyDebateStyle()
        }

        router?.go(to: .pinEntry)
    }

}
