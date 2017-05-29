//
//  Created by Jakub Turek on 29.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Foundation

class NotificationManagingMock: NotificationManaging {

    var observedNotifications: [Notification.Name] = []
    var callbacks: [Notification.Name: ((Notification) -> Void)] = [:]
    var removedObserver = false

    func addObserver(forName name: Notification.Name?,
                     object obj: Any?,
                     queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        if let notification = name {
            observedNotifications.append(notification)
            callbacks[notification] = block
        }

        return NSObject()
    }

    func removeObserver(_ observer: Any) {
        removedObserver = true
    }

}
