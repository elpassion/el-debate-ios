//
//  ErrorAlertController.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 17/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol AlertShowing {
    func show(in controller: UIViewController, title: String, message: String)
}

class ErrorAlertController: AlertShowing {
    func show(in controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        controller.present(alert, animated: true)
    }
}
