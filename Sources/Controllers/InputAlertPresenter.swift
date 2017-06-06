//
//  Created by Jakub Turek on 06.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

protocol InputAlertPresenting {

    func prompt(in controller: UIViewController, withTitle title: String) -> Promise<String?>

}

class InputAlertPresenter: InputAlertPresenting {

    func prompt(in controller: UIViewController, withTitle title: String) -> Promise<String?> {
        return Promise { fullfil, _ in
            let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Comment"
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in fullfil(nil) }
            let sendAction = UIAlertAction(title: "Send", style: .default) { [weak alert] _ in
                fullfil(alert?.textFields?.first?.text)
            }

            alert.addAction(cancelAction)
            alert.addAction(sendAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }

}
