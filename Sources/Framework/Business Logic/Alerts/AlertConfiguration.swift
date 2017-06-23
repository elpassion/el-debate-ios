//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

public struct AlertConfiguration {

    let title: String?
    let message: String?
    let actions: [AlertActionConfiguration]
    let textFields: [AlertTextFieldConfiguration]

}

public struct AlertActionConfiguration {

    let title: String
    let style: UIAlertActionStyle
    let handler: (() -> Void)?

}

public struct AlertTextFieldConfiguration {

    let placeholder: String

}

// MARK: - Equatables

extension AlertConfiguration: Equatable {

    public static func == (lhs: AlertConfiguration, rhs: AlertConfiguration) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.message &&
            lhs.actions == rhs.actions && lhs.textFields == rhs.textFields
    }

}

extension AlertActionConfiguration: Equatable {

    public static func == (lhs: AlertActionConfiguration, rhs: AlertActionConfiguration) -> Bool {
        return lhs.title == rhs.title && lhs.style == rhs.style
    }

}

extension AlertTextFieldConfiguration: Equatable {

    public static func == (lhs: AlertTextFieldConfiguration, rhs: AlertTextFieldConfiguration) -> Bool {
        return lhs.placeholder == rhs.placeholder
    }

}
