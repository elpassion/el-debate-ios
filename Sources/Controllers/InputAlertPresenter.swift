//
//  Created by Jakub Turek on 06.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

protocol InputAlertPresenting {

    func prompt(in controller: UIViewController, with configuration: InputAlertConfiguration) -> Promise<String?>

}

class InputAlertPresenter: InputAlertPresenting {

    func prompt(in controller: UIViewController, with configuration: InputAlertConfiguration) -> Promise<String?> {
        return Promise { fulfill, _ in
            let alert = UIAlertController(title: configuration.title,
                                          message: configuration.message,
                                          preferredStyle: .alert)

            alert.addTextField { textField in
                textField.placeholder = configuration.inputPlaceholder
            }

            let cancelAction = UIAlertAction(title: configuration.cancelTitle, style: .cancel) { _ in
                fulfill(nil)
            }

            let sendAction = UIAlertAction(title: configuration.okTitle, style: .default) { [weak alert] _ in
                fulfill(alert?.textFields?.first?.text)
            }

            alert.addAction(cancelAction)
            alert.addAction(sendAction)

            controller.present(alert, animated: true, completion: nil)
        }
    }

}
