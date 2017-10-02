import UIKit

public struct AlertConfiguration {

    let title: String?
    let message: String?
    let actions: [AlertActionConfiguration]

}

// MARK: - Equatable

extension AlertConfiguration: Equatable {

    public static func == (lhs: AlertConfiguration, rhs: AlertConfiguration) -> Bool {
        return lhs.title == rhs.title && lhs.message == rhs.message &&
            lhs.actions == rhs.actions
    }

}
