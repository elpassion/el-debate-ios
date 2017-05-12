//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol ControllerConfiguring: AutoMockable {

    func configure(controller: ControllerProviding, with router: Router)

}

class ControllerConfigurator: ControllerConfiguring {

    func configure(controller: ControllerProviding, with router: Router) {

    }

}
