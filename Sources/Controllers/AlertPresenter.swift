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

    @discardableResult
    func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool>

}

class AlertPresenter: AlertShowing {

    @discardableResult
    func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool> {
        return Promise { fulfill, _ in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in fulfill(true) }
            alert.addAction(okAction)
            controller.present(alert, animated: true)
        }
    }

}

protocol AlertPresentingController {

    var alertPresenter: AlertShowing { get }
    var controller: UIViewController { get }

}

@discardableResult
func presentAlert(in alertPresenting: AlertPresentingController?, title: String?, message: String?) -> Promise<Bool> {
    guard let alertPresenting = alertPresenting else {
        return Promise(error: RequestError.deallocatedClientError)
    }

    return alertPresenting.alertPresenter.show(in: alertPresenting.controller,
                                               title: title ?? "",
                                               message: message ?? "")
}
