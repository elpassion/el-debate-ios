//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

public protocol AlertCreating {

    func makeAlert(with configuration: AlertConfiguration) -> UIAlertController

}

public class AlertFactory: AlertCreating {

    public func makeAlert(with configuration: AlertConfiguration) -> UIAlertController {
        let controller = UIAlertController(title: configuration.title,
                                           message: configuration.message,
                                           preferredStyle: .alert)

        for action in configuration.actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.handler?()
            }

            controller.addAction(alertAction)
        }

        for fieldConfiguration in configuration.textFields {
            controller.addTextField { textField in
                textField.placeholder = fieldConfiguration.placeholder
            }
        }

        return controller
    }

}

extension AlertFactory {

    static func build() -> AlertFactory {
        return AlertFactory()
    }

}
