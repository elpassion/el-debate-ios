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
