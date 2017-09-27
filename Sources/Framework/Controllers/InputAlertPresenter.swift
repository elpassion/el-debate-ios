import PromiseKit
import UIKit

protocol InputAlertPresenting {

    func prompt(in controller: UIViewController, with configuration: InputAlertConfiguration) -> Promise<String?>

}

class InputAlertPresenter: InputAlertPresenting {

    func prompt(in controller: UIViewController, with configuration: InputAlertConfiguration) -> Promise<String?> {
        return prompt(in: controller, with: configuration, alertFactory: AlertFactory.build())
    }

    func prompt(in controller: UIViewController,
                with configuration: InputAlertConfiguration,
                alertFactory: AlertCreating) -> Promise<String?> {
        return Promise { fulfill, _ in
            var alert: UIAlertController?

            let cancelAction = AlertActionConfiguration(title: configuration.cancelTitle,
                                                        style: .cancel) { fulfill(nil) }
            let sendAction = AlertActionConfiguration(title: configuration.okTitle,
                                                      style: .default) {
                fulfill(alert?.textFields?.first?.text)
            }

            let inputField = AlertTextFieldConfiguration(placeholder: configuration.inputPlaceholder)

            let alertConfiguration = AlertConfiguration(title: configuration.title,
                                                        message: configuration.message,
                                                        actions: [cancelAction, sendAction],
                                                        textFields: [inputField])

            alert = alertFactory.makeAlert(with: alertConfiguration)

            if let alert = alert {
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }

}
