import UIKit

public struct AlertActionConfiguration {

    let title: String
    let style: UIAlertAction.Style
    let handler: (() -> Void)?

}

// MARK: - Equatable

extension AlertActionConfiguration: Equatable {

    public static func == (lhs: AlertActionConfiguration, rhs: AlertActionConfiguration) -> Bool {
        return lhs.title == rhs.title && lhs.style == rhs.style
    }

}
