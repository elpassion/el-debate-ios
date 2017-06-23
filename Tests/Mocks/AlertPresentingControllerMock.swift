//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

class AlertPresentingControllerMock: AlertPresentingController {

    let controller = UIViewController()

    var alertPresenter: AlertShowing {
        return presenterMock
    }

    let presenterMock = AlertShowingMock()

}
