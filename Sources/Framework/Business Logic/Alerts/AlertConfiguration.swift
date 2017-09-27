import UIKit

public struct AlertConfiguration {

    let title: String?
    let message: String?
    let actions: [AlertActionConfiguration]
    let textFields: [AlertTextFieldConfiguration]

}

// MARK: - Equatables

extension AlertConfiguration: Equatable {

    public static func == (lhs: AlertConfiguration, rhs: AlertConfiguration) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.message &&
            lhs.actions == rhs.actions && lhs.textFields == rhs.textFields
    }

}
