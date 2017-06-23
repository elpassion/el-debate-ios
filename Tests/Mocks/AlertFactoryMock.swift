//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

internal class AlertFactoryMock: AlertCreating {

    var returnedAlert = UIAlertController()
    var lastConfiguration: AlertConfiguration?

    func makeAlert(with configuration: AlertConfiguration) -> UIAlertController {
        self.lastConfiguration = configuration
        return returnedAlert
    }

}
