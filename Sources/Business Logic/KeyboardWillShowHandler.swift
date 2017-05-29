//
//  Created by Jakub Turek on 29.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol KeyboardWillShowHandling {

    var onKeyboardHeightChanged: ((CGFloat) -> Void)? { get set }

}

class KeyboardWillShowHandler: KeyboardWillShowHandling {

    private let notificationManager: NotificationManaging

    var onKeyboardHeightChanged: ((CGFloat) -> Void)?

    // MARK: - Initializer

    init(notificationManager: NotificationManaging) {
        self.notificationManager = notificationManager

        registerToNotifications()
    }

    private func registerToNotifications() {
        notificationManager.addObserver(for: TypedNotification.keyboardWillShow) { [weak self] payload in
            self?.onKeyboardHeightChanged?(payload.height)
        }

        notificationManager.addObserver(for: TypedNotification.keyboardWillHide) { [weak self] _ in
            self?.onKeyboardHeightChanged?(0.0)
        }
    }

    // MARK: - Deinitializer

    deinit {
        notificationManager.removeObserver(self)
    }

}
