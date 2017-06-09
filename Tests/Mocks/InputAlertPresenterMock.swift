//
//  Created by Jakub Turek on 06.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import PromiseKit

class InputAlertPresenterMock: InputAlertPresenting {

    var returnValue: Promise<String?> = Promise(value: "comment")
    var receivedController: UIViewController?
    var receivedConfiguration: InputAlertConfiguration?

    func prompt(in controller: UIViewController, with configuration: InputAlertConfiguration) -> Promise<String?> {
        receivedController = controller
        receivedConfiguration = configuration

        return returnValue
    }

}
