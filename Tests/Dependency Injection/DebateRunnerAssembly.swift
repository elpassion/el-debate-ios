//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Swinject

class DebateRunnerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Routing.self) { (_, navigationController: UINavigationController) in
            return RouterMock(navigator: navigationController)
        }
    }

}
