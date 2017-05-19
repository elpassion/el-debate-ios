//
//  AlertViewMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 17/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import UIKit
import PromiseKit

class AlertViewMock: AlertShowing {
    var wasShown: Bool = false

    @discardableResult func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool>  {
        wasShown = true
        return Promise(value: true)
    }
}
