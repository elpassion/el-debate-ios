//
//  AlertViewMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 17/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import UIKit

class AlertViewMock: AlertShowing {
    var wasShown: Bool = false

    func show(in controller: UIViewController, title: String, message: String)  {
        wasShown = true
    }
}
