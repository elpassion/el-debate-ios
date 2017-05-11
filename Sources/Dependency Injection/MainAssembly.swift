//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject

class MainAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MainWindowCreating.self) { _ in MainWindowFactory(screenBounds: UIScreen.main.bounds) }
        container.register(Routing.self) { _ in Router(navigator: UINavigationController()) }
    }

}
