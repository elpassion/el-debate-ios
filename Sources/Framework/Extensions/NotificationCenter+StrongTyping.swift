import Foundation

extension NotificationManaging {

    @discardableResult
    func addObserver<T>(for descriptor: NotificationDescriptor<T>, object: Any?,
                        queue: OperationQueue?, using block: @escaping (T) -> Void) -> NSObjectProtocol {
        return addObserver(forName: descriptor.name, object: object, queue: queue) { notification in
            guard let parsed = descriptor.parser(notification.userInfo ?? [:]) else {
                fatalError("Could not parse notification \(notification) with descriptor \(descriptor)")
            }

            block(parsed)
        }
    }

    @discardableResult
    func addObserver<T>(for descriptor: NotificationDescriptor<T>,
                        using block: @escaping (T) -> Void) -> NSObjectProtocol {
        return addObserver(for: descriptor, object: nil, queue: nil, using: block)
    }

}
