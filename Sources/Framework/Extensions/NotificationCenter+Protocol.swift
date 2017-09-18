import Foundation

protocol NotificationManaging {

    func addObserver(forName name: Notification.Name?,
                     object obj: Any?,
                     queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol

    func removeObserver(_ observer: Any)

}

extension NotificationCenter: NotificationManaging {}
