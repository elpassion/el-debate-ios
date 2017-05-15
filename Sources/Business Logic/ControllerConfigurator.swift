//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol ControllerConfiguring: AutoMockable {

    func configure(controller: ControllerProviding, with router: Routing)

}

class ControllerConfigurator: ControllerConfiguring {

    func configure(controller: ControllerProviding, with router: Routing) {
        if let controller = controller as? PinEntryControllerProviding {
            controller.onDebateLoaded = { _ in router.go(to: .answer) }
        }
    }

}
