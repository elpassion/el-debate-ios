//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

internal class PresentControllerSpy: UIViewController {

    var hasPresentedController: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        self.hasPresentedController = viewControllerToPresent
    }

}
