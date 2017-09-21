@testable import ELDebateFramework

internal class AlertFactoryMock: AlertCreating {

    var returnedAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    var lastConfiguration: AlertConfiguration?

    func makeAlert(with configuration: AlertConfiguration) -> UIAlertController {
        self.lastConfiguration = configuration
        return returnedAlert
    }

}
