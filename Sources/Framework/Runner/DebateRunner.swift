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

    public convenience init() {
        let assembler = Assembler.defaultAssembler

        self.init(resolver: assembler.resolver)
    }

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    private(set) var router: Routing?

    public func start(in navigationController: UINavigationController, applyingDebateStyle: Bool) {
        router = resolver ~> (Routing.self, argument: navigationController)

        if applyingDebateStyle {
            navigationController.applyDebateStyle()
        }

        router?.go(to: .pinEntry)
    }

}
