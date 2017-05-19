//
//  AlertPresenter.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 17/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

protocol AlertShowing {
    @discardableResult func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool>
}

class AlertPresenter: AlertShowing {
    @discardableResult func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool> {
        return Promise { fulfill, _ in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in fulfill(true) }
            alert.addAction(okAction)
            controller.present(alert, animated: true)
        }
    }
}
