@testable import ELDebateFramework

class AlertPresentingControllerMock: AlertPresentingController {

    let controller = UIViewController()

    var alertPresenter: AlertShowing {
        return presenterMock
    }

    let presenterMock = AlertShowingMock()

}
