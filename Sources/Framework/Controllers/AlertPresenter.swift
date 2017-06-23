//
//  AlertPresenter.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 17/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

protocol AlertShowing: AutoMockable {

    @discardableResult
    func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool>

}

class AlertPresenter: AlertShowing {

    @discardableResult
    func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool> {
        return show(in: controller, title: title, message: message, alertFactory: AlertFactory.build())
    }

    @discardableResult
    func show(in controller: UIViewController, title: String, message: String,
              alertFactory: AlertCreating) -> Promise<Bool> {
        return Promise { fulfill, _ in
            let okAction = AlertActionConfiguration(title: "Ok", style: .default) { _ in fulfill(true) }
            let configuration = AlertConfiguration(title: title, message: message, actions: [okAction], textFields: [])

            let alert = alertFactory.makeAlert(with: configuration)

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

@discardableResult
func presentErrorAlert(for error: Error, in alertPresenting: AlertPresentingController?,
                       defaultMessage: String) -> Promise<Bool> {
    let message: String

    if let alertPresentableError = error as? AlertPresentableError {
        message = alertPresentableError.errorMessage
    } else {
        message = defaultMessage
    }

    return presentAlert(in: alertPresenting, title: "Error", message: message)
}
