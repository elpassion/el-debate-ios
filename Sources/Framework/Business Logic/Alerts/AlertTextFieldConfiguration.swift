import UIKit

public struct AlertTextFieldConfiguration {

    let placeholder: String

}

// MARK: - Equatable

extension AlertTextFieldConfiguration: Equatable {

    public static func == (lhs: AlertTextFieldConfiguration, rhs: AlertTextFieldConfiguration) -> Bool {
        return lhs.placeholder == rhs.placeholder
    }

}
